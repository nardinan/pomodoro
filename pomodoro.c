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
#include "director.obj.h"
#include "loader.obj.h"
#include "module_configuration.obj.h"
#define d_pomodoro_title "Pomodoro"
#define d_pomodoro_resources "./data"
#define d_pomodoro_resources_default_png 	"./data/placeholders/default_png.png"
#define d_pomodoro_resources_default_ttf 	"./data/placeholders/default_ttf.ttf"
#define d_pomodoro_resources_default_json 	"./data/placeholders/default_json.json"
#define d_pomodoro_resources_default_ogg	"./data/placeholders/default_ogg.wav"
#define d_pomodoro_resources_default_lisp   "./data/placeholders/default_lisp.lisp"
struct s_object *resources_png, *resources_ttf, *resources_ogg, *resources_json, *resources_lisp;
struct s_object *factory;
struct s_object *ui_factory;
/* menu interfaces */
struct s_object *module_buttons_container, *module_configuration_container;
struct s_object *module_configuration;
unsigned int current_loop = 0;
t_boolean v_developer_mode = d_false, v_continue_execution = d_true;
void f_pomodoro_initialize_resources(void) {
    struct s_exception *exception;
    struct s_object *resources_path = f_string_new_constant(d_new(string), d_pomodoro_resources),
                    *template_png   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_png),
                    *template_ttf   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ttf),
                    *template_json  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_json),
                    *template_ogg   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ogg),
                    *template_lisp  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_lisp);
    d_try {
        d_assert(resources_png = f_resources_new_template(d_new(resources), resources_path, template_png, ".png"));
        d_assert(resources_ttf = f_resources_new_template(d_new(resources), resources_path, template_ttf, ".ttf"));
        d_assert(resources_json = f_resources_new_template(d_new(resources), resources_path, template_json, ".json"));
        d_assert(resources_ogg = f_resources_new_template(d_new(resources), resources_path, template_ogg, ".wav.ogg"));
        d_assert(resources_lisp = f_resources_new_template(d_new(resources), resources_path, template_lisp, ".lisp"));
        d_delete(template_lisp);
        d_delete(template_ogg);
        d_delete(template_json);
        d_delete(template_ttf);
        d_delete(template_png);
        d_delete(resources_path);
    } d_catch(exception) {
        d_exception_dump(stderr, exception);
        d_raise;
    } d_endtry;
}

void f_pomodoro_initialize_game(struct s_object *self, void **parameters, size_t entries) {
    struct s_object *environment = (struct s_object *)parameters[0];
    if (module_buttons_container)
        d_call(ui_factory, m_ui_factory_hide_container, environment, module_buttons_container);
    if (module_configuration_container)
        d_call(ui_factory, m_ui_factory_hide_container, environment, module_configuration_container);
    d_call(director, m_director_reload_collector, NULL);
    d_call(director, m_director_set_language, (int)d_pomodoro_language);
    d_call(director, m_director_run_script, "initialize_script");
}

void f_pomodoro_finalize_game(struct s_object *self, void **parameters, size_t entries) {
    v_continue_execution = d_false;
}

int pomodoro_load_call(struct s_object *environment) {
    struct s_exception *exception;
    struct s_object *stream_ui, *stream_configuration;
    struct s_object *json_ui, *json_configuration;
    struct s_uiable_container *container,
                              *button_configuration,
                              *button_play,
                              *button_quit;
    d_try {
        if ((factory = f_factory_new(d_new(factory), resources_png, resources_ttf, resources_json, resources_ogg, resources_lisp, environment))) {
            if ((director = f_director_new(d_new(director), factory))) {
                d_assert(stream_configuration = d_call(resources_json, m_resources_get_stream, d_factory_configuration, e_resources_type_common));
                if ((json_configuration = f_json_new_stream(d_new(json), stream_configuration))) {
                    d_assert(stream_ui = d_call(resources_json, m_resources_get_stream, d_factory_ui, e_resources_type_common));
                    if ((json_ui = f_json_new_stream(d_new(json), stream_ui))) {
                        if ((ui_factory = f_ui_factory_new(d_new(ui_factory), resources_png, resources_json, director, environment, 
                                        json_configuration, json_ui))) {
                            d_assert(container = d_call(ui_factory, m_ui_factory_get_component, NULL, "main_buttons"));
                            module_buttons_container = container->uiable;
                            if ((module_configuration = f_module_configuration_new(d_new(module_configuration), environment, resources_json, resources_png, 
                                            ui_factory))) {
                                d_assert(module_configuration_container = d_call(module_configuration, m_module_configuration_get_uiable, environment));
                                d_assert(button_configuration = d_call(ui_factory, m_ui_factory_get_component, container, "button_setup"));
                                d_call(button_configuration->uiable, m_emitter_embed_parameter, "clicked_left", module_configuration_container);
                                d_call(button_configuration->uiable, m_emitter_embed_parameter, "clicked_left", environment);
                                d_call(button_configuration->uiable, m_emitter_embed_function, "clicked_left", f_ui_factory_callback_visibility);
                                d_assert(button_play = d_call(ui_factory, m_ui_factory_get_component, container, "button_play"));
                                d_call(button_play->uiable, m_emitter_embed_parameter, "clicked_left", environment);
                                d_call(button_play->uiable, m_emitter_embed_function, "clicked_left", f_pomodoro_initialize_game);
                                d_assert(button_quit = d_call(ui_factory, m_ui_factory_get_component, container, "button_quit"));
                                d_call(button_quit->uiable, m_emitter_embed_parameter, "clicked_left", environment);
                                d_call(button_quit->uiable, m_emitter_embed_function, "clicked_left", f_pomodoro_finalize_game);
                                d_call(ui_factory, m_ui_factory_show_container, environment, module_buttons_container);
                            } else
                                d_die(d_error_malloc);
                        } else
                            d_die(d_error_malloc);
                        d_delete(json_ui);
                    } else 
                        d_die(d_error_malloc);
                    d_delete(json_configuration);
                } else
                    d_die(d_error_malloc);
            } else 
                d_die(d_error_malloc);
        } else
            d_die(d_error_malloc);
    } d_catch(exception) {
        d_exception_dump(stderr, exception);
        d_raise;
    } d_endtry;
    return d_true;
}

int pomodoro_loop_call(struct s_object *environment) {
    d_call(director, m_director_update, NULL);
    return v_continue_execution;
}

int pomodoro_quit_call(struct s_object *environment) {
    if (module_configuration) 
        d_delete(module_configuration);
    d_delete(resources_png);
    d_delete(resources_ttf);
    d_delete(resources_json);
    d_delete(resources_ogg);
    d_delete(resources_lisp);
    d_delete(director);
    d_delete(factory);
    d_delete(ui_factory);
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
    d_pool_begin("main context") {
        /* wait the unlock */
        d_try {
            f_pomodoro_initialize_resources();
            if ((stream_configuation = d_call(resources_json, m_resources_get_stream, d_factory_configuration, e_resources_type_common))) {
                if ((json_configuration = f_json_new_stream(d_new(json), stream_configuation))) {
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_width_window, "s", "width");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_height_window, "s", "height");
                    d_call(json_configuration, m_json_get_boolean, &d_pomodoro_fullscreen, "s", "fullscreen");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_general_volume, "s", "volume");
                    d_call(json_configuration, m_json_get_double, &d_pomodoro_language, "s", "language");
                    d_delete(json_configuration);
                }
            }
            scale_resolution_x = (d_pomodoro_width * d_pomodoro_scale_factor);
            scale_resolution_y = (d_pomodoro_height * d_pomodoro_scale_factor);
            environment = f_environment_new_fullscreen(d_new(environment), d_pomodoro_width_window, d_pomodoro_height_window, d_pomodoro_fullscreen);
            d_call(environment, m_environment_set_methods, &pomodoro_load_call, &pomodoro_loop_call, &pomodoro_quit_call);
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
