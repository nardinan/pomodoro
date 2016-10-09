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
#ifndef pomodoro_puppeteer_h
#define pomodoro_puppeteer_h
#include "character.obj.h"
#define d_puppeteer_default_layer 5
typedef struct s_puppeteer_character { d_list_node_head;
    char label[d_entity_label_size];
    struct s_object *character;
    t_boolean controllable;
} s_puppeteer_character;
d_declare_class(puppeteer) {
    struct s_attributes head;
    struct s_object *factory;
    struct s_list characters;
} d_declare_class_tail(puppeteer);
struct s_puppeteer_attributes *p_puppeteer_alloc(struct s_object *self);
extern struct s_object *f_puppeteer_new(struct s_object *self, struct s_object *factory, t_entity_validator validator);
d_declare_method(puppeteer, get_character)(struct s_object *self, const char *key);
d_declare_method(puppeteer, hide_characters)(struct s_object *self);
d_declare_method(puppeteer, show_character)(struct s_object *self, const char *key, double position_x);
d_declare_method(puppeteer, delete)(struct s_object *self, struct s_puppeteer_attributes *attributes);
#endif
