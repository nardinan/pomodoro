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
#ifndef pomodoro_item_h
#define pomodoro_item_h
#include "factory.obj.h"
#define d_item_lost_square_distance 2570000
#define d_item_max_square_distance 257000
#define d_item_blink_modificator 10.0
#define d_item_blink_max_channel 254.0
#define d_item_blink_min_channel 0.0
typedef struct s_item_track {
  d_list_node_head;
  char label[d_entity_label_size];
  struct s_object *track;
  int volume;
} s_item_track;
d_declare_class(item) {
  struct s_attributes head;
  double width, height;
  struct s_list tracks;
  struct s_item_track *current_track;
  double green_channel, green_modificator;
  t_boolean active, solid, audio, blink;
} d_declare_class_tail(item);
struct s_item_attributes *p_item_alloc(struct s_object *self, const char *key);
extern struct s_object *f_item_new(struct s_object *self, const char *key);
d_declare_method(item, load)(struct s_object *self, struct s_object *json, struct s_object *factory);
d_declare_method(item, mute)(struct s_object *self);
d_declare_method(item, play)(struct s_object *self);
d_declare_method(item, set_component)(struct s_object *self, char *label);
d_declare_method(item, set_solid)(struct s_object *self, t_boolean solid);
d_declare_method(item, set_active)(struct s_object *self, t_boolean active);
d_declare_method(item, blink)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed);
d_declare_method(item, collision)(struct s_object *self, struct s_object *entity);
d_declare_method(item, draw)(struct s_object *self, struct s_object *environment);
d_declare_method(item, delete)(struct s_object *self, struct s_item_attributes *attributes);
#endif
