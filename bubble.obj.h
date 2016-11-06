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
#ifndef pomodoro_bubble_h
#define pomodoro_bubble_h
#include "factory.obj.h"
#define d_bubble_queue_size 32
#define d_bubble_message_size 1024
#define d_bubble_characters_per_line 32
#define d_bubble_layer_default 10
typedef struct s_bubble_message { d_list_node_head;
    char content[d_bubble_message_size];
    int font_ID;
    time_t timeout;
} s_bubble_message;
typedef struct s_bubble_component { d_list_node_head;
    char content[d_bubble_characters_per_line + 1];
    struct s_object *component;
    double offset_y, offset_x;
} s_bubble_component;
d_declare_class(bubble) {
    struct s_attributes head;
    struct s_list messages, components;
    struct s_bubble_message *current_element;
    struct s_object *factory;
    struct s_object *drawables[e_uiable_component_NULL];
    int font_style;
    time_t last_update;
    unsigned int mask_R, mask_G, mask_B, mask_A;
} d_declare_class_tail(bubble);
struct s_bubble_attributes *p_bubble_alloc(struct s_object *self);
extern struct s_object *f_bubble_new(struct s_object *self, struct s_object *factory, unsigned int red, unsigned int green, unsigned int blue, 
        unsigned int alpha, int font_style);
d_declare_method(bubble, set)(struct s_object *self, struct s_object *drawable, enum e_uiable_components component);
d_declare_method(bubble, add_message)(struct s_object *self, const char *message, time_t timeout, int font_ID);
d_declare_method(bubble, skip)(struct s_object *self);
d_declare_method(bubble, draw)(struct s_object *self, struct s_object *environment);
d_declare_method(bubble, delete)(struct s_object *self, struct s_bubble_attributes *attributes);
#endif
