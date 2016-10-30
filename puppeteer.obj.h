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
/* action definition */
typedef enum e_puppeteer_actions {
    e_puppeteer_action_hide,
    e_puppeteer_action_show,
    e_puppeteer_action_enable_control,
    e_puppeteer_action_disable_control,
    e_puppeteer_action_say,
    e_puppeteer_action_set,
    e_puppeteer_action_move
} e_puppeteer_action;
typedef struct s_puppeteer_action_say {
    char message[d_string_buffer_size];
    double timeout;
} s_puppeteer_action_say;
typedef struct s_puppeteer_action {
    enum e_puppeteer_actions type;
    char key[d_entity_label_size];
    union {
        struct s_puppeteer_action_say action_say;
        char entry[d_string_buffer_size];
        double destination_x;
    } parameters;
} s_puppeteer_action;
extern struct s_lisp_object *p_link_puppeteer_hide_characters(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_show_character(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_enable_control(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_disable_control(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_say_character(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_set_character(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_puppeteer_move_character(struct s_object *self, struct s_lisp_object *arguments);
/* end */
typedef struct s_puppeteer_character { d_list_node_head;
    char label[d_entity_label_size];
    struct s_object *character;
    t_boolean controllable;
} s_puppeteer_character;
d_declare_class(puppeteer) {
    struct s_attributes head;
    struct s_object *factory;
    struct s_list characters;
    struct s_object *main_character;
} d_declare_class_tail(puppeteer);
struct s_puppeteer_attributes *p_puppeteer_alloc(struct s_object *self);
extern struct s_object *f_puppeteer_new(struct s_object *self, struct s_object *factory, t_entity_validator validator);
d_declare_method(puppeteer, get_character)(struct s_object *self, const char *key);
d_declare_method(puppeteer, hide_characters)(struct s_object *self);
d_declare_method(puppeteer, show_character)(struct s_object *self, const char *key, double position_x);
d_declare_method(puppeteer, enable_control)(struct s_object *self, const char *key);
d_declare_method(puppeteer, disable_control)(struct s_object *self);
d_declare_method(puppeteer, say_character)(struct s_object *self, const char *key, const char *message, time_t timeout);
d_declare_method(puppeteer, set_character)(struct s_object *self, const char *key, const char *entry);
d_declare_method(puppeteer, move_character)(struct s_object *self, const char *key, double destination_x);
d_declare_method(puppeteer, set_main_character)(struct s_object *self, const char *key);
d_declare_method(puppeteer, get_main_character)(struct s_object *self);
d_declare_method(puppeteer, linker)(struct s_object *self, struct s_object *script);
d_declare_method(puppeteer, dispatcher)(struct s_object *self, struct s_puppeteer_action *action);
d_declare_method(puppeteer, delete)(struct s_object *self, struct s_puppeteer_attributes *attributes);
#endif
