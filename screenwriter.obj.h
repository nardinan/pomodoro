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
#ifndef pomodoro_screenwriter_h
#define pomodoro_screenwriter_h
#include "factory.obj.h"
#include "bubble.obj.h"
typedef enum e_screenwriter_languages {
    e_screenwriter_language_eng = 0,
    e_screenwriter_language_ita,
    e_screenwriter_language_NULL
} e_screenwriter_languages;
typedef struct s_screenwriter_option { d_list_node_head;
    unsigned int ID;
    int next_ID;
    char content[e_screenwriter_language_NULL][d_bubble_message_size], symbol[d_lisp_symbol_size];
    double value;
} s_screenwriter_option;
typedef struct s_screenwriter_entry { d_list_node_head;
    unsigned int ID;
    int next_ID;
    char entity[d_entity_label_size], content[e_screenwriter_language_NULL][d_bubble_message_size];
    time_t delay;
    struct s_list options;
} s_screenwriter_entry;
d_declare_class(screenwriter) {
    struct s_attributes head;
    struct s_list dialogs;
    struct s_screenwriter_entry *current_entry;
    struct s_object *factory;
    struct s_object *puppeteer;
    struct s_object *collector;
    enum e_screenwriter_languages language;
    t_boolean started, completed;
} d_declare_class_tail(screenwriter);
struct s_screenwriter_attributes *p_screenwriter_alloc(struct s_object *self);
extern struct s_object *f_screenwriter_new(struct s_object *self, struct s_object *factory, struct s_object *puppeteer, struct s_object *collector);
d_declare_method(screenwriter, set_language)(struct s_object *self, enum e_screenwriter_languages language);
d_declare_method(screenwriter, load)(struct s_object *self, struct s_object *json);
d_declare_method(screenwriter, run)(struct s_object *self, const char *label);
d_declare_method(screenwriter, get)(struct s_object *self, unsigned int ID);
d_declare_method(screenwriter, update)(struct s_object *self);
d_declare_method(screenwriter, delete)(struct s_object *self, struct s_screenwriter_attributes *attributes);
#endif
