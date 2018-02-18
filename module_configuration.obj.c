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
#include "module_configuration.obj.h"
const char *v_configuration_resolutions[] = {
    "1024x576",
    "1280x720",
    "1366x768",
    "1600x900",
    "1920x1080",
    "2560x1800",
    NULL
}, *v_configuration_languages[] = {
    "english",
    "italian",
    NULL
};
struct s_module_configuration_attributes *p_module_configuration_alloc(struct s_object *self) {
    struct s_module_configuration_attributes *result = d_prepare(self, module_configuration);
    f_memory_new(self);	/* inherit */
    f_mutex_new(self);	/* inherit */
    return result;
}

struct s_object *f_module_configuration_new(struct s_object *self, struct s_object *environment, struct s_object *resources_json, 
        struct s_object *resources_png, struct s_object *ui_factory) {
    struct s_module_configuration_attributes *attributes = p_module_configuration_alloc(self);
    struct s_uiable_container *configuration_container, *button_apply, *button_reset;
    attributes->ui_factory = d_retain(ui_factory);
    attributes->resources_json = d_retain(resources_json);
    attributes->resources_png = d_retain(resources_png);
    d_assert(configuration_container = d_call(attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(button_apply = d_call(attributes->ui_factory, m_ui_factory_get_component, configuration_container, "button_apply"));
    d_call(button_apply->uiable, m_emitter_embed_parameter, "clicked_left", self);
    d_call(button_apply->uiable, m_emitter_embed_parameter, "clicked_left", environment);
    d_call(button_apply->uiable, m_emitter_embed_function, "clicked_left", p_module_configuration_apply);
    d_assert(button_reset = d_call(attributes->ui_factory, m_ui_factory_get_component, configuration_container, "button_reset"));
    d_call(button_reset->uiable, m_emitter_embed_function, "clicked_left", p_module_configuration_reset);
    return self;
}

d_define_method(module_configuration, fill_resources)(struct s_object *self, struct s_object *environment) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container, *list_resolutions, *list_languages, *checkbox_fullscreen, *scroll_volume;
    struct s_object *current_label;
    int index;
    char current_resolution[d_string_buffer_size];
    snprintf(current_resolution, d_string_buffer_size, "%dx%d", (int)d_pomodoro_width_window, (int)d_pomodoro_height_window);
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(list_resolutions = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "resolution_list"));
    d_assert(list_languages = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "language_list"));
    d_assert(scroll_volume = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "volume_scroll"));
    if (d_pomodoro_fullscreen) {
        d_assert(checkbox_fullscreen = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, 
                    "fullscreen_checkbox"));
        d_call(checkbox_fullscreen->uiable, m_checkbox_set_checked, d_true);
    }
    for (index = 0; v_configuration_resolutions[index]; ++index) 
        if ((current_label = d_call(module_configuration_attributes->ui_factory, m_ui_factory_new_label, d_ui_factory_default_font_id, 
                        d_ui_factory_default_font_style, v_configuration_resolutions[index]))) {
            d_call(list_resolutions->uiable, m_list_add_uiable, current_label);
            if (f_string_strcmp(current_resolution, v_configuration_resolutions[index]) == 0)
                d_call(list_resolutions->uiable, m_list_set_selected_uiable, current_label);
            d_delete(current_label);
        }
    for (index = 0; v_configuration_languages[index]; ++index)
        if ((current_label = d_call(module_configuration_attributes->ui_factory, m_ui_factory_new_label, d_ui_factory_default_font_id, 
                        d_ui_factory_default_font_style, v_configuration_languages[index]))) {
            d_call(list_languages->uiable, m_list_add_uiable, current_label);
            if (d_pomodoro_language == index)
                d_call(list_languages->uiable, m_list_set_selected_uiable, current_label);
            d_delete(current_label);
        }
    /* Volume goes from 0 to 2.0 (by default 1.5) - the scroll goes from 0 to 255 so we need to normalize the value */
    d_call(scroll_volume->uiable, m_scroll_set_position, (int)((d_pomodoro_general_volume * 255.0)/2.0)); 
    return self;
}

d_define_method(module_configuration, get_resolution)(struct s_object *self, double *width, double *height) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container, *list_resolutions;
    struct s_object *selected_element;
    char buffer[d_string_buffer_size], *current_resolution, *pointer;
    ssize_t *selection;
    int index;
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(list_resolutions = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "resolution_list"));
    if ((selection = d_call(list_resolutions->uiable, m_list_get_selected_uiable, NULL))) {
        for (index = 0; index < d_list_max_selected; ++index)
            if (selection[index] == d_list_selected_NULL)
                break;
        if (index > 0)
            if ((selected_element = d_call(list_resolutions->uiable, m_list_get_uiable, (unsigned int)selection[(index-1)])))
                if ((current_resolution = (char *)d_call(selected_element, m_label_get_content_char, NULL))) {
                    strcpy(buffer, current_resolution);
                    if ((pointer = strchr(buffer, 'x'))) {
                        *pointer = 0;
                        ++pointer;
                        *width = atof(buffer);
                        *height = atof(pointer);
                    }
                }
    }
    return self;
}

d_define_method(module_configuration, get_language)(struct s_object *self, double *language) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container, *list_languages;
    ssize_t *selection;
    int index;
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(list_languages = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "language_list"));
    if ((selection = d_call(list_languages->uiable, m_list_get_selected_uiable, NULL))) {
        for (index = 0; index < d_list_max_selected; ++index)
            if (selection[index] == d_list_selected_NULL)
                break;
        if (index > 0)
            *language = (double)selection[(index - 1)];
    }
    return self;
}

d_define_method(module_configuration, get_volume)(struct s_object *self, double *volume) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container, *scroll_volume;
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(scroll_volume = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, "volume_scroll"));
    *volume = ((double)((intptr_t)d_call(scroll_volume->uiable, m_scroll_get_position, NULL) * 2))/255.0;
    return self;
}

d_define_method(module_configuration, get_fullscreen)(struct s_object *self, t_boolean *fullscreen) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container, *checkbox_fullscreen;
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_assert(checkbox_fullscreen = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, resources_container, 
                "fullscreen_checkbox"));
    *fullscreen = (intptr_t)d_call(checkbox_fullscreen->uiable, m_checkbox_get_checked, NULL);
    return self;
}

d_define_method(module_configuration, get_uiable)(struct s_object *self, struct s_object *environment) {
    d_using(module_configuration);
    struct s_uiable_container *resources_container;
    d_assert(resources_container = d_call(module_configuration_attributes->ui_factory, m_ui_factory_get_component, NULL, "configuration_panel"));
    d_call(self, m_module_configuration_fill_resources, environment);
    return resources_container->uiable;
}

d_define_method(module_configuration, delete)(struct s_object *self, struct s_module_configuration_attributes *attributes) {
    d_delete(attributes->ui_factory);
    d_delete(attributes->resources_json);
    d_delete(attributes->resources_png);
    return NULL;
}

d_define_class(module_configuration) {
    d_hook_method(module_configuration, e_flag_private, fill_resources),
        d_hook_method(module_configuration, e_flag_public, get_resolution),
        d_hook_method(module_configuration, e_flag_public, get_language),
        d_hook_method(module_configuration, e_flag_public, get_volume),
        d_hook_method(module_configuration, e_flag_public, get_fullscreen),
        d_hook_method(module_configuration, e_flag_public, get_uiable),
        d_hook_delete(module_configuration),
        d_hook_method_tail
};

void p_module_configuration_reset(struct s_object *self, void **parameters, size_t entries) {
    unlink(d_collector_dump);
}

void p_module_configuration_apply(struct s_object *self, void **parameters, size_t entries) {
    struct s_object *module_configuration = (struct s_object *)parameters[0];
    struct s_object *environment = (struct s_object *)parameters[1];
    struct s_object *stream_configuation, *stream_configuration_write;
    struct s_object *json_configuration;
    struct s_exception *exception;
    struct s_module_configuration_attributes *module_configuration_attributes = d_cast(module_configuration, module_configuration);
    struct s_stream_attributes *stream_attributes;
    double width = d_pomodoro_width_window, height = d_pomodoro_height_window, language = d_pomodoro_language, volume = d_pomodoro_general_volume;
    t_boolean fullscreen = d_pomodoro_fullscreen;
    d_call(module_configuration, m_module_configuration_get_fullscreen, &d_pomodoro_fullscreen);
    d_call(module_configuration, m_module_configuration_get_resolution, &d_pomodoro_width_window, &d_pomodoro_height_window);
    d_call(module_configuration, m_module_configuration_get_language, &d_pomodoro_language);
    d_call(module_configuration, m_module_configuration_get_volume, &d_pomodoro_general_volume);
    if ((width != d_pomodoro_width_window) ||  (height != d_pomodoro_height_window) || (fullscreen != d_pomodoro_fullscreen) ||
            (language != d_pomodoro_language) || (volume != d_pomodoro_general_volume)) {
        d_call(environment, m_environment_set_fullscreen, d_pomodoro_fullscreen);
        d_call(environment, m_environment_set_size, (int)d_pomodoro_width_window, (int)d_pomodoro_height_window);
        d_try {
            if ((stream_configuation = d_call(module_configuration_attributes->resources_json, m_resources_get_stream, d_factory_configuration, 
                            e_resources_type_common))) {
                stream_attributes = d_cast(stream_configuation, stream);
                if ((json_configuration = f_json_new_stream(d_new(json), stream_configuation))) {
                    d_call(json_configuration, m_json_set_double, d_pomodoro_width_window, "s", "width");
                    d_call(json_configuration, m_json_set_double, d_pomodoro_height_window, "s", "height");
                    d_call(json_configuration, m_json_set_boolean, d_pomodoro_fullscreen, "s", "fullscreen");
                    d_call(json_configuration, m_json_set_double, d_pomodoro_general_volume, "s", "volume");
                    d_call(json_configuration, m_json_set_double, d_pomodoro_language, "s", "language");
                    if ((stream_configuration_write = f_stream_new_file(d_new(stream), stream_attributes->string_name, "w", 0777))) {
                        d_call(json_configuration, m_json_write, stream_configuration_write);
                        d_delete(stream_configuration_write);
                    }
                    d_delete(json_configuration);
                }
            }
        } d_catch(exception) {
            d_exception_dump(stderr, exception);
        } d_endtry;
    }
}
