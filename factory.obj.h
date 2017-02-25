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
#ifndef pomodoro_factory_h
#define pomodoro_factory_h
#include "miranda.h"
#define d_factory_animation_frame_time 100.0
#define d_factory_configuration "pomodoro_config"
#define d_factory_default_font_size 30.0
#define d_factory_default_font_outline 0.0
#define d_factory_max_channels 128
typedef enum e_factory_media_types {
    e_factory_media_type_bitmap = 0,
    e_factory_media_type_animation,
    e_factory_media_type_particle,
    e_factory_media_type_track,
    e_factory_media_type_NULL
} e_factory_media_types;
d_declare_class(factory) {
    struct s_attributes head;
    struct s_object *environment;
    struct s_object *font_system;
    struct s_object *resources_png, *resources_ttf, *resources_json, *resources_ogg, *resources_lisp;
    struct s_object *json_configuration;
    int current_channel, current_language;
} d_declare_class_tail(factory);
struct s_factory_attributes *p_factory_alloc(struct s_object *self);
extern struct s_object *f_factory_new(struct s_object *self, struct s_object *resources_png, struct s_object *resources_ttf, struct s_object *resources_json,
        struct s_object *resources_ogg, struct s_object *resources_lisp, struct s_object *environment);
d_declare_method(factory, get_language)(struct s_object *self);
d_declare_method(factory, get_bitmap)(struct s_object *self, const char *label);
d_declare_method(factory, get_animation)(struct s_object *self, const char *label);
d_declare_method(factory, get_particle_structure)(struct s_object *self, struct s_object *json, struct s_particle_configuration_core *configuration, 
        const char *prefix);
d_declare_method(factory, get_particle)(struct s_object *self, const char *label);
d_declare_method(factory, get_media)(struct s_object *self, const char *label, enum e_factory_media_types *selected_type);
d_declare_method(factory, get_json)(struct s_object *self, const char *label);
d_declare_method(factory, get_font)(struct s_object *self, int ID, int style, int *height);
d_declare_method(factory, get_script)(struct s_object *self, const char *label);
d_declare_method(factory, get_track)(struct s_object *self, const char *label);
d_declare_method(factory, delete)(struct s_object *self, struct s_factory_attributes *attributes);
#endif
