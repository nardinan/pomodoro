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
#ifndef pomodoro_character_h
#define pomodoro_character_h
#include "bubble.obj.h"
#define d_character_default_speed 10
#define d_character_default_font 0
typedef enum e_character_components {
    e_character_component_hair = 0,
    e_character_component_eyes,
    e_character_component_head,
    e_character_component_arms,
    e_character_component_legs,
    e_character_component_body,
    e_character_component_NULL
} e_character_components;
typedef enum e_character_directions { 
    e_character_direction_left = 0,
    e_character_direction_right,
    e_character_direction_up,
    e_character_direction_down,
    e_character_direction_NULL
} e_character_directions;
extern const char *v_character_components_label[e_character_component_NULL],
       *v_character_directions_label[e_character_direction_NULL];
d_declare_class(character) {
    struct s_attributes head;
    enum e_character_directions direction;
    struct s_object *bubble;
    double bubble_offset_x, bubble_offset_y, destination_x, source_x;
    t_boolean movement, set;
} d_declare_class_tail(character);
struct s_character_attributes *p_character_alloc(struct s_object *self, const char *key, t_entity_validator validator);
extern struct s_object *f_character_new(struct s_object *self, const char *key, t_entity_validator validator);
d_declare_method(character, load)(struct s_object *self, struct s_object *json, struct s_object *factory);
d_declare_method(character, move_left)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(character, move_right)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(character, move_up)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(character, move_down)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(character, say)(struct s_object *self, const char *message, time_t timeout);
d_declare_method(character, move)(struct s_object *self, double destination_x);
d_declare_method(character, draw)(struct s_object *self, struct s_object *environment);
d_declare_method(character, delete)(struct s_object *self, struct s_character_attributes *attributes);
#endif
