/*
 * pomodoro
 * Copyright (C) 2016 Andrea Nardinocchi (andrea@nardinan.it)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "loader.obj.h"
struct s_object *loader;
/* menu interfaces */
struct s_object *module_buttons_container, *module_configuration_container;
struct s_object *module_configuration;
struct s_object *bitmap_loading_screen;
t_boolean v_developer_mode = d_false, v_continue_execution = d_true, v_initialized = d_false;
void f_pomodoro_initialize_game(struct s_object *self, void **parameters, size_t entries) {
    struct s_object *environment = (struct s_object *)parameters[0];
    struct s_object *loader      = (struct s_object *)parameters[1];
    struct s_loader_attributes *loader_attributes = d_cast(loader, loader);
    if (module_buttons_container)
        d_call(loader_attributes->ui_factory, m_ui_factory_hide_container, environment, module_buttons_container);
    if (module_configuration_container)
        d_call(loader_attributes->ui_factory, m_ui_factory_hide_container, environment, module_configuration_container);
    d_call(loader_attributes->director, m_director_reload_collector, NULL);
    d_call(loader_attributes->director, m_director_set_language, (int)d_pomodoro_language);
    d_call(loader_attributes->director, m_director_run_script, "initialize_script");
}

void f_pomodoro_finalize_game(struct s_object *self, void **parameters, size_t entries) {
    v_continue_execution = d_false;
}

int pomodoro_load_call_initialize(struct s_object *environment) {
    struct s_object *stream_loading_screen;
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    double width, height;
    d_pool_begin("initialize_context") {
        if ((stream_loading_screen = f_stream_new_file(d_new(stream), d_pkstr(d_pomodoro_resources_loading), "r", 0777))) {
            if ((bitmap_loading_screen = f_bitmap_new(d_new(bitmap), stream_loading_screen, environment))) {
                d_call(bitmap_loading_screen, m_drawable_get_dimension, &width, &height);
                d_call(bitmap_loading_screen, m_drawable_set_position, (double)0.0, 
                        (double)(environment_attributes->reference_h[e_environment_surface_ui] - height));
                d_call(environment, m_environment_add_drawable, bitmap_loading_screen, 0, e_environment_surface_ui);
            }
            d_delete(stream_loading_screen);
        }
    } d_pool_end;
    if ((loader = f_loader_new(d_new(loader), environment)))
        d_call(loader, m_runnable_run, NULL);
    return d_true;
}

int pomodoro_load_call_complete(struct s_object *environment) {
    struct s_exception *exception;
    struct s_uiable_container *container,
                              *button_configuration,
                              *button_play,
                              *button_quit;
    struct s_loader_attributes *loader_attributes = d_cast(loader, loader);
    d_call(loader, m_runnable_join, NULL);
    d_try {
        d_assert(container = d_call(loader_attributes->ui_factory, m_ui_factory_get_component, NULL, "main_buttons"));
        module_buttons_container = container->uiable;
        if ((module_configuration = f_module_configuration_new(d_new(module_configuration), environment, loader_attributes->resources_json, 
                        loader_attributes->resources_png, loader_attributes->ui_factory))) {
            d_assert(module_configuration_container = d_call(module_configuration, m_module_configuration_get_uiable, environment));
            d_assert(button_configuration = d_call(loader_attributes->ui_factory, m_ui_factory_get_component, container, "button_setup"));
            d_call(button_configuration->uiable, m_emitter_embed_parameter, "clicked_left", module_configuration_container);
            d_call(button_configuration->uiable, m_emitter_embed_parameter, "clicked_left", environment);
            d_call(button_configuration->uiable, m_emitter_embed_function, "clicked_left", f_ui_factory_callback_visibility);
            d_assert(button_play = d_call(loader_attributes->ui_factory, m_ui_factory_get_component, container, "button_play"));
            d_call(button_play->uiable, m_emitter_embed_parameter, "clicked_left", environment);
            d_call(button_play->uiable, m_emitter_embed_parameter, "clicked_left", loader);
            d_call(button_play->uiable, m_emitter_embed_function, "clicked_left", f_pomodoro_initialize_game);
            d_assert(button_quit = d_call(loader_attributes->ui_factory, m_ui_factory_get_component, container, "button_quit"));
            d_call(button_quit->uiable, m_emitter_embed_parameter, "clicked_left", environment);
            d_call(button_play->uiable, m_emitter_embed_parameter, "clicked_left", loader);
            d_call(button_quit->uiable, m_emitter_embed_function, "clicked_left", f_pomodoro_finalize_game);
            d_call(loader_attributes->ui_factory, m_ui_factory_show_container, environment, module_buttons_container);
        } else
            d_die(d_error_malloc);
    } d_catch(exception) {
        d_exception_dump(stderr, exception);
        d_raise;
    } d_endtry;
    return d_true;
}

int pomodoro_loop_call(struct s_object *environment) {
    struct s_loader_attributes *loader_attributes = d_cast(loader, loader);
    if (!v_initialized) {
        if (!d_call(loader, m_runnable_running, NULL)) {
            /* loading has been completed */
            d_call(environment, m_environment_del_drawable, bitmap_loading_screen, 0, e_environment_surface_ui);
            d_log(e_log_level_ever, "loading has been completed");
            v_initialized = d_true;
            pomodoro_load_call_complete(environment);
        }
    } else
        d_call(loader_attributes->director, m_director_update, NULL);
    return v_continue_execution;
}

int pomodoro_quit_call(struct s_object *environment) {
    if (!v_initialized)
        d_call(loader, m_runnable_join, NULL);
    d_delete(loader);
    if (module_configuration)
        d_delete(module_configuration);
    d_delete(bitmap_loading_screen);
    return d_true;
}

void pomodoro_change_location(const char *application) {
    char buffer[PATH_MAX], *pointer;
    if ((pointer = strrchr(application, '/'))) {
        memset(buffer, 0, PATH_MAX);
        strncpy(buffer, application, (pointer - application));
        chdir(buffer);
        d_log(e_log_level_ever, "changing local path to: %s", buffer);
    }
}

int main (int argc, char *argv[]) {
    struct s_exception *exception;
    struct s_object *environment;
    struct s_object *stream_configuation;
    struct s_object *json_configuration;
    double scale_resolution_x, scale_resolution_y;
    d_pool_init;
    d_pool_begin("main context") {
        v_log_level = e_log_level_ever;
        /* change chmod to the current location of the application */
        pomodoro_change_location(argv[0]);
        if ((argc > 1) && (f_string_strcmp(argv[1], "-developer") == 0)) {
            v_log_level = e_log_level_high;
            d_war(e_log_level_ever, "developer mode has been enabled");
            v_developer_mode = d_true;
        }
        if ((argc > 1) && (f_string_strcmp(argv[1], "-fullscreen") == 0)) {
            d_war(e_log_level_ever, "fullscreen mode has been enabled");
            d_pomodoro_fullscreen = d_true;
        }
        /* wait the unlock */
        d_try {
            if ((stream_configuation = f_stream_new_file(d_new(stream), d_pkstr(d_pomodoro_resources_configuration), "r", 0777))) {
                if ((json_configuration = f_json_new_stream(d_new(json), stream_configuation))) {
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_width_window, "s", "width");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_height_window, "s", "height");
                    d_call(json_configuration, m_json_get_boolean, &d_pomodoro_fullscreen, "s", "fullscreen");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_general_volume, "s", "volume");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_language, "s", "language");
                    d_delete(json_configuration);
                }
                d_delete(stream_configuation);
            }
            scale_resolution_x = (d_pomodoro_width * d_pomodoro_scale_factor);
            scale_resolution_y = (d_pomodoro_height * d_pomodoro_scale_factor);
            environment = f_environment_new_fullscreen(d_new(environment), d_pomodoro_width_window, d_pomodoro_height_window, d_pomodoro_fullscreen);
            d_call(environment, m_environment_set_methods, &pomodoro_load_call_initialize, &pomodoro_loop_call, &pomodoro_quit_call);
            d_call(environment, m_environment_set_reference, scale_resolution_x, scale_resolution_y, e_environment_surface_primary);
            d_call(environment, m_environment_set_reference, scale_resolution_x, scale_resolution_y, e_environment_surface_ui);
            d_call(environment, m_environment_set_focus, 0.0, 0.0, e_environment_surface_primary);
            d_call(environment, m_environment_set_focus, 0.0, 0.0, e_environment_surface_ui);
            d_call(environment, m_environment_set_title, d_pomodoro_title);
            d_call(environment, m_environment_set_channels, d_factory_max_channels);
            d_call(environment, m_environment_run_loop, NULL);
            d_delete(environment);
        } d_catch(exception) {
            d_exception_dump(stderr, exception);
        } d_endtry;
    } d_pool_end;
    d_pool_destroy;
    f_memory_destroy();
    return 0;
}
