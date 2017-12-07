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
#ifndef pomodoro_effecteer_h
#define pomodoro_effecteer_h
#include "factory.obj.h"
#define d_effecteer_default_back_layer 2
#define d_effecteer_default_front_layer 8
#define d_effecteer_default_max_tracks 16
/* action definition */
typedef enum e_effecteer_actions {
    e_effecteer_action_add,
    e_effecteer_action_stop,
    e_effecteer_action_play,
    e_effecteer_action_delete
} e_effecteer_actions;
typedef struct s_effecteer_action_add {
    char label[d_string_buffer_size];
    double position_x, position_y, zoom, angle;
    t_boolean absolute, front;
} s_effecteer_action_add;
typedef struct s_effecteer_action_play {
    char label[d_string_buffer_size];
    int fade_in, fade_out, volume;
    t_boolean loop;
} s_effecteer_action_play;
typedef struct s_effecteer_action {
    enum e_effecteer_actions type;
    char key[d_entity_label_size];
    union {
        struct s_effecteer_action_add action_add;
        struct s_effecteer_action_play action_play;
    } parameters;
} s_effecteer_action;
extern struct s_lisp_object *p_link_effecteer_add_effect(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_effecteer_stop_effect(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_effecteer_play_effect(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_effecteer_delete_effect(struct s_object *self, struct s_lisp_object *arguments);
/* end */
typedef struct s_effecteer_effect { d_list_node_head;
    char key[d_entity_label_size];
    struct s_object *drawable;
    enum e_factory_media_types type;
    double position_x, position_y, zoom, angle;
    int layer;
    t_boolean absolute;
} s_effecteer_effect;
typedef struct s_effecteer_track {
    char key[d_entity_label_size];
    struct s_object *track;
    int fade_in, fade_out, volume;
    t_boolean loop;
} s_effecteer_track;
d_declare_class(effecteer) {
    struct s_attributes head;
    struct s_object *factory;
    struct s_list components;
    struct s_effecteer_track tracks[d_effecteer_default_max_tracks];
} d_declare_class_tail(effecteer);
struct s_effecteer_attributes *p_effecteer_alloc(struct s_object *self);
extern struct s_object *f_effecteer_new(struct s_object *self, struct s_object *factory);
d_declare_method(effecteer, get_effect)(struct s_object *self, const char *key);
d_declare_method(effecteer, add_effect)(struct s_object *self, const char *key, const char *label, double position_x, double position_y, t_boolean absolute, 
        double zoom, double angle, int layer);
d_declare_method(effecteer, play_effect)(struct s_object *self, const char *key, const char *label, int fade_in, int fade_out, int volume, t_boolean loop);
d_declare_method(effecteer, stop_effect)(struct s_object *self, const char *key);
d_declare_method(effecteer, delete_effect)(struct s_object *self, const char *key);
d_declare_method(effecteer, linker)(struct s_object *self, struct s_object *script);
d_declare_method(effecteer, dispatcher)(struct s_object *self, struct s_effecteer_action *action);
d_declare_method(effecteer, delete)(struct s_object *self, struct s_effecteer_attributes *attributes);
#endif
