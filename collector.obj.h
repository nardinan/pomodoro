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
#ifndef pomodoro_collector_h
#define pomodoro_collector_h
#define d_collector_dump_string "string"
#define d_collector_dump_double "double"
#define d_collector_dump "./collector.dump.dat"
#include "miranda.h"
/* action defintion */
typedef enum e_collector_types {
  e_collector_type_string,
  e_collector_type_double
} e_collector_types;
typedef struct s_collector_entry {
  d_list_node_head;
  char key[d_lisp_symbol_size];
  enum e_collector_types type;
  union {
    double value_double;
    char *value_string;
  } value;
} s_collector_entry;
typedef enum e_collector_actions {
  e_collector_action_set
} e_collector_actions;
typedef struct s_collector_action {
  enum e_collector_actions type;
  union {
    struct s_collector_entry action_set;
  } parameters;
} s_collector_action;
extern struct s_lisp_object *p_link_collector_set(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_collector_get(struct s_object *self, struct s_lisp_object *arguments);
/* end */
d_declare_class(collector) {
  struct s_attributes head;
  struct s_list pool;
} d_declare_class_tail(collector);
struct s_collector_attributes *p_collector_alloc(struct s_object *self);
extern struct s_object *f_collector_new(struct s_object *self);
d_declare_method(collector, get_entry)(struct s_object *self, const char *key);
d_declare_method(collector, add_entry)(struct s_object *self, const char *key);
d_declare_method(collector, add_entry_double)(struct s_object *self, const char *key, double value);
d_declare_method(collector, add_entry_string)(struct s_object *self, const char *key, const char *value);
d_declare_method(collector, reload)(struct s_object *self);
d_declare_method(collector, linker)(struct s_object *self, struct s_object *script);
d_declare_method(collector, dispatcher)(struct s_object *self, struct s_collector_action *action);
d_declare_method(collector, delete)(struct s_object *self, struct s_collector_attributes *attributes);
#endif
