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
#define d_bubble_message_size 1024
#define d_bubble_characters_per_line 32
#define d_bubble_default_layer 10
#define d_bubble_select_character 0x11
#define d_bubble_empty_character 0x0a
#define d_bubble_no_value -1
typedef enum e_bubble_positions {
    e_bubble_position_right = 0,
    e_bubble_position_left
} e_bubble_positions;
typedef struct s_bubble_option { d_list_node_head;
    char content[d_bubble_message_size];
    int value;
} s_bubble_option;
typedef struct s_bubble_message { d_list_node_head;
    char content[d_bubble_message_size];
    struct s_list options;
    int font_ID, selected_option;
    time_t timeout;
    t_boolean force_kill;
} s_bubble_message;
typedef struct s_bubble_component { d_list_node_head;
    char content[d_bubble_characters_per_line + 1];
    struct s_object *component;
    double offset_y, offset_x, width, height;
} s_bubble_component;
d_declare_class(bubble) {
    struct s_attributes head;
    struct s_list messages, components;
    struct s_bubble_message *current_element, *last_element;
    struct s_object *factory;
    struct s_object *drawables[e_uiable_component_NULL + 1];
    double maximum_width, total_height;
    int font_style, last_value;
    time_t last_update;
    unsigned int mask_R, mask_G, mask_B, mask_A;
    enum e_bubble_positions current_position;
} d_declare_class_tail(bubble);
struct s_bubble_attributes *p_bubble_alloc(struct s_object *self);
extern struct s_object *f_bubble_new(struct s_object *self, struct s_object *factory, unsigned int red, unsigned int green, unsigned int blue, 
        unsigned int alpha, int font_style);
d_declare_method(bubble, set)(struct s_object *self, struct s_object *drawable, enum e_uiable_components component);
d_declare_method(bubble, add_message)(struct s_object *self, const char *message, time_t timeout, int font_ID);
d_declare_method(bubble, add_option)(struct s_object *self, const char *option, int value);
d_declare_method(bubble, move_up)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(bubble, move_down)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(bubble, select)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(bubble, append_components)(struct s_object *self, char *message, TTF_Font *selected_font, int font_height, struct s_object *environment);
d_declare_method(bubble, skip)(struct s_object *self);
d_declare_method(bubble, draw)(struct s_object *self, struct s_object *environment);
d_declare_method(bubble, delete)(struct s_object *self, struct s_bubble_attributes *attributes);
#endif
