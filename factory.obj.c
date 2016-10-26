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
#include "factory.obj.h"
struct s_factory_attributes *p_factory_alloc(struct s_object *self) {
    struct s_factory_attributes *result = d_prepare(self, factory);
    f_memory_new(self);         /* inherit */
    f_mutex_new(self);          /* inherit */
    return result;
}

struct s_object *f_factory_new(struct s_object *self, struct s_object *resources_png, struct s_object *resources_ttf, struct s_object *resources_json,
        struct s_object *resources_ogg, struct s_object *resources_lisp, struct s_object *environment) {
    struct s_factory_attributes *attributes = p_factory_alloc(self);
    struct s_object *font;
    struct s_object *stream;
    double font_size, font_outline;
    char *game_buffer, *name_buffer, *mail_buffer, *font_buffer;
    int index = 0;
    attributes->resources_png = d_retain(resources_png);
    attributes->resources_ttf = d_retain(resources_ttf);
    attributes->resources_json = d_retain(resources_json);
    attributes->resources_ogg = d_retain(resources_ogg);
    attributes->resources_lisp = d_retain(resources_lisp);
    attributes->environment = d_retain(environment);
    if ((attributes->font_system = f_fonts_new(d_new(fonts)))) {
        if ((stream = d_call(attributes->resources_json, m_resources_get_stream, d_factory_configuration, e_resources_type_common)))
            if ((attributes->json_configuration = f_json_new_stream(d_new(json), stream))) {
                d_call(attributes->json_configuration, m_json_get_string, &game_buffer, "s", "game");
                d_call(attributes->json_configuration, m_json_get_string, &name_buffer, "s", "author");
                d_call(attributes->json_configuration, m_json_get_string, &mail_buffer, "s", "email");
                d_log(e_log_level_ever, "[%s - developed by %s (%s)]", game_buffer, name_buffer, mail_buffer);
                while (d_call(attributes->json_configuration, m_json_get_string, &font_buffer, "sds", "fonts", index, "font")) {
                    font_size = d_factory_default_font_size;
                    font_outline = d_factory_default_font_outline;
                    d_call(attributes->json_configuration, m_json_get_double, &font_size, "sds", "fonts", index, "size");
                    d_call(attributes->json_configuration, m_json_get_double, &font_outline, "sds", "fonts", index, "outline");
                    if ((font = d_call(attributes->resources_ttf, m_resources_get_stream, font_buffer, e_resources_type_common))) {
                        d_call(attributes->font_system, m_fonts_add_font, index, font, (int)font_size);
                        if (font_outline > 0)
                            d_call(attributes->font_system, m_fonts_set_outline, index, (int)font_outline);
                    }
                    ++index;
                }
            }
    } else
        d_die(d_error_malloc);
    return self;
}

d_define_method(factory, get_bitmap)(struct s_object *self, const char *label) {
    d_using(factory);
    struct s_object *stream;
    struct s_object *result = NULL;
    if ((stream = d_call(factory_attributes->resources_png, m_resources_get_stream_strict, label, e_resources_type_common)))
        result = f_bitmap_new(d_new(bitmap), stream, factory_attributes->environment);
    return result;
}

d_define_method(factory, get_animation)(struct s_object *self, const char *label) {
    d_using(factory);
    struct s_object *stream;
    struct s_object *bitmap;
    struct s_object *json;
    struct s_object *result = NULL;
    enum e_drawable_flips flip;
    char *string_supply;
    t_boolean animation_flip_x = d_false, animation_flip_y = d_false, frame_flip_x, frame_flip_y;
    double offset_x, offset_y, zoom, time, time_ratio = 1.0, cycles = d_animation_infinite_loop;
    int index = 0;
    if ((stream = d_call(factory_attributes->resources_json, m_resources_get_stream_strict, label, e_resources_type_common)))
        if ((json = f_json_new_stream(d_new(json), stream))) {
            if (d_call(json, m_json_get_string, &string_supply, "s", "format"))
                if (f_string_strcmp(string_supply, "animation") == 0) {
                    d_call(json, m_json_get_double, &time_ratio, "s", "time_ratio");
                    d_call(json, m_json_get_double, &cycles, "s", "cycles");
                    d_call(json, m_json_get_boolean, &animation_flip_x, "s", "flip_x");
                    d_call(json, m_json_get_boolean, &animation_flip_y, "s", "flip_y");
                    if ((result = f_animation_new(d_new(animation), (int)cycles, time_ratio))) {
                        while ((d_call(json, m_json_get_string, &string_supply, "sds", "frames", index, "drawable"))) {
                            offset_x = 0.0;
                            offset_y = 0.0;
                            zoom = 1.0;
                            time = d_factory_animation_frame_time;
                            frame_flip_x = animation_flip_x;
                            frame_flip_y = animation_flip_y;
                            d_call(json, m_json_get_double, &offset_x, "sds", "frames", index, "offset_x");
                            d_call(json, m_json_get_double, &offset_y, "sds", "frames", index, "offset_y");
                            d_call(json, m_json_get_double, &zoom, "sds", "frames", index, "zoom");
                            d_call(json, m_json_get_double, &time, "sds", "frames", index, "time");
                            d_call(json, m_json_get_boolean, &frame_flip_x, "sds", "frames", index, "flip_x");
                            d_call(json, m_json_get_boolean, &frame_flip_y, "sds", "frames", index, "flip_y");
                            if ((bitmap = d_call(self, m_factory_get_bitmap, string_supply, factory_attributes->environment))) {
                                if ((frame_flip_x) && (frame_flip_y))
                                    flip = e_drawable_flip_both;
                                else if (frame_flip_x)
                                    flip = e_drawable_flip_horizontal;
                                else if (frame_flip_y)
                                    flip = e_drawable_flip_vertical;
                                else
                                    flip = e_drawable_flip_none;
                                d_call(bitmap, m_drawable_flip, flip);
                                d_call(result, m_animation_append_frame, bitmap, offset_x, offset_y, zoom, time);
                                d_delete(bitmap);
                            }
                            ++index;
                        }
                    } else 
                        d_die(d_error_malloc);
                }
            d_delete(json);
        }
    return result;
}

d_define_method(factory, get_particle_structure)(struct s_object *self, struct s_object *json, struct s_particle_configuration_core *configuration,
        const char *prefix) {
    memset(configuration, 0, sizeof(struct s_particle_configuration_core));
    d_call(json, m_json_get_double, &(configuration->position_x), "ss", prefix, "position_x");
    d_call(json, m_json_get_double, &(configuration->position_y), "ss", prefix, "position_y");
    d_call(json, m_json_get_double, &(configuration->zoom), "ss", prefix, "zoom");
    d_call(json, m_json_get_double, &(configuration->angle), "ss", prefix, "angle");
    d_call(json, m_json_get_double, &(configuration->gravity_x), "ss", prefix, "gravity_x");
    d_call(json, m_json_get_double, &(configuration->gravity_y), "ss", prefix, "gravity_y");
    d_call(json, m_json_get_double, &(configuration->direction_angle), "ss", prefix, "direction_angle");
    d_call(json, m_json_get_double, &(configuration->speed_linear), "ss", prefix, "speed_linear");
    d_call(json, m_json_get_double, &(configuration->speed_direction_angle), "ss", prefix, "speed_direction_angle");
    d_call(json, m_json_get_double, &(configuration->speed_zoom), "ss", prefix, "speed_zoom");
    d_call(json, m_json_get_double, &(configuration->speed_angle), "ss", prefix, "speed_angle");
    d_call(json, m_json_get_double, &(configuration->mask_R), "ss", prefix, "mask_R");
    d_call(json, m_json_get_double, &(configuration->mask_G), "ss", prefix, "mask_G");
    d_call(json, m_json_get_double, &(configuration->mask_B), "ss", prefix, "mask_B");
    d_call(json, m_json_get_double, &(configuration->mask_A), "ss", prefix, "mask_A");
    d_call(json, m_json_get_double, &(configuration->speed_R), "ss", prefix, "speed_R");
    d_call(json, m_json_get_double, &(configuration->speed_G), "ss", prefix, "speed_G");
    d_call(json, m_json_get_double, &(configuration->speed_B), "ss", prefix, "speed_B");
    d_call(json, m_json_get_double, &(configuration->speed_A), "ss", prefix, "speed_A");
    d_call(json, m_json_get_double, &(configuration->lifetime), "ss", prefix, "lifetime");
    return self;
}

d_define_method(factory, get_particle)(struct s_object *self, const char *label) {
    d_using(factory);
    struct s_object *stream;
    struct s_object *bitmap;
    struct s_object *json;
    struct s_object *result = NULL;
    struct s_particle_configuration particle_configuration;
    enum e_drawable_flips flip;
    double particles, emission_rate;
    char *string_supply;
    t_boolean core_flip_x = d_false, core_flip_y = d_false;
    memset(&(particle_configuration), 0, sizeof(s_particle_configuration));
    if ((stream = d_call(factory_attributes->resources_json, m_resources_get_stream_strict, label, e_resources_type_common)))
        if ((json = f_json_new_stream(d_new(json), stream))) {
            if (d_call(json, m_json_get_string, &string_supply, "s", "format"))
                if (f_string_strcmp(string_supply, "particle") == 0) {
                    d_call(json, m_json_get_double, &particles, "s", "particles");
                    d_call(json, m_json_get_double, &emission_rate, "s", "emission_rate");
                    d_call(json, m_json_get_boolean, &core_flip_x, "s", "flip_x");
                    d_call(json, m_json_get_boolean, &core_flip_y, "s", "flip_y");
                    d_call(json, m_json_get_string, &string_supply, "s", "blend");
                    particle_configuration.blend = e_drawable_blend_none;
                    if (f_string_strcmp(string_supply, "add") == 0)
                        particle_configuration.blend = e_drawable_blend_add;
                    else if (f_string_strcmp(string_supply, "alpha") == 0)
                        particle_configuration.blend = e_drawable_blend_alpha;
                    else if (f_string_strcmp(string_supply, "mod") == 0)
                        particle_configuration.blend = e_drawable_blend_mod;
                    particle_configuration.particles = particles;
                    particle_configuration.emission_rate = emission_rate;
                    d_call(self, m_factory_get_particle_structure, json, &(particle_configuration.minimum), "minimum");
                    d_call(self, m_factory_get_particle_structure, json, &(particle_configuration.maximum), "maximum");
                    if ((d_call(json, m_json_get_string, &string_supply, "s", "drawable")))
                        if ((bitmap = d_call(self, m_factory_get_bitmap, string_supply, factory_attributes->environment))) {
                            if ((core_flip_x) && (core_flip_y))
                                flip = e_drawable_flip_both;
                            else if (core_flip_x)
                                flip = e_drawable_flip_horizontal;
                            else if (core_flip_y)
                                flip = e_drawable_flip_vertical;
                            else
                                flip = e_drawable_flip_none;
                            d_call(bitmap, m_drawable_flip, flip);
                            if (!(result = f_particle_new(d_new(particle), bitmap, factory_attributes->environment, &(particle_configuration))))
                                d_die(d_error_malloc);
                            d_delete(bitmap);
                        }
                }
            d_delete(json);
        }
    return result;
}

d_define_method(factory, get_media)(struct s_object *self, const char *label, enum e_factory_media_types *selected_type) {
    struct s_object *result = NULL;
    *selected_type = e_factory_media_type_bitmap;
    if (!(result = d_call(self, m_factory_get_bitmap, label))) {
        *selected_type = e_factory_media_type_animation;
        if (!(result = d_call(self, m_factory_get_animation, label))) {
            *selected_type = e_factory_media_type_particle;
            if (!(result = d_call(self, m_factory_get_particle, label)))
                *selected_type = e_factory_media_type_NULL;
        }
    }
    return result;
}

d_define_method(factory, get_json)(struct s_object *self, const char *label) {
    d_using(factory);
    struct s_object *stream;
    struct s_object *result = NULL;
    if ((stream = d_call(factory_attributes->resources_json, m_resources_get_stream_strict, label, e_resources_type_common)))
        result = f_json_new_stream(d_new(json), stream);
    return result;
}

d_define_method(factory, get_font)(struct s_object *self, int ID, int style, int *height) {
    d_using(factory);
    *height = (intptr_t)d_call(factory_attributes->font_system, m_fonts_get_height, ID);
    d_cast_return(d_call(factory_attributes->font_system, m_fonts_get_font, ID, style));
}

d_define_method(factory, get_script)(struct s_object *self, const char *label) {
    d_using(factory);
    struct s_object *stream;
    struct s_object *result = NULL;
    if ((stream = d_call(factory_attributes->resources_lisp, m_resources_get_stream_strict, label, e_resources_type_common)))
        result = f_lisp_new(d_new(lisp), stream, STDOUT_FILENO);
    return result;
}

d_define_method(factory, delete)(struct s_object *self, struct s_factory_attributes *attributes) {
    d_delete(attributes->resources_png);
    d_delete(attributes->resources_ttf);
    d_delete(attributes->resources_json);
    d_delete(attributes->resources_ogg);
    d_delete(attributes->resources_lisp);
    d_delete(attributes->environment);
    d_delete(attributes->font_system);
    if (attributes->json_configuration)
        d_delete(attributes->json_configuration);
    return NULL;
}

d_define_class(factory) {
    d_hook_method(factory, e_flag_public, get_bitmap),
        d_hook_method(factory, e_flag_public, get_animation),
        d_hook_method(factory, e_flag_private, get_particle_structure),
        d_hook_method(factory, e_flag_public, get_particle),
        d_hook_method(factory, e_flag_public, get_media),
        d_hook_method(factory, e_flag_public, get_json),
        d_hook_method(factory, e_flag_public, get_font),
        d_hook_method(factory, e_flag_public, get_script),
        d_hook_delete(factory),
        d_hook_method_tail
};

