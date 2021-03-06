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
#ifndef pomodoro_landscape_h
#define pomodoro_landscape_h
#include "factory.obj.h"
#include "item.obj.h"
#define d_landscape_surface_default_layer 1
#define d_landscape_item_default_layer 3
#define d_landscape_fade_in_time 1000
typedef struct s_landscape_surface {
  d_list_node_head;
  struct s_object *drawable;
  double offset_x, offset_y, speed_ratio_x, speed_ratio_y;
  int layer;
  t_boolean reference;
} s_landscape_surface;
typedef struct s_landscape_script {
  d_list_node_head;
  char label[d_entity_label_size], script[d_resources_key_size];
  time_t last_update, frequency;
  t_boolean first_execution;
} s_landscape_script;
typedef struct s_landscape_point {
  d_list_node_head;
  double position_x, position_y, dimension_h, scale_min, scale_max;
} s_landscape_point;
typedef struct s_landscape_item {
  d_list_node_head;
  char label[d_entity_label_size], script[d_resources_key_size];
  struct s_object *item;
  double position_x, position_y;
  int layer;
} s_landscape_item;
typedef struct s_landscape_track {
  d_list_node_head;
  char label[d_entity_label_size];
  struct s_object *track;
} s_landscape_track;
d_declare_class(landscape) {
  struct s_attributes head;
  char label[d_entity_label_size], intro_script[d_string_buffer_size], outro_script[d_string_buffer_size];
  struct s_list surfaces, points, items, tracks, scripts;
  double position_x, position_y;
} d_declare_class_tail(landscape);
struct s_landscape_attributes *p_landscape_alloc(struct s_object *self);
extern struct s_object *f_landscape_new(struct s_object *self, const char *key);
d_declare_method(landscape, load)(struct s_object *self, struct s_object *json, struct s_object *factory);
d_declare_method(landscape, show)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, hide)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, stop)(struct s_object *self);
d_declare_method(landscape, play)(struct s_object *self, const char *label);
d_declare_method(landscape, set_item_solid)(struct s_object *self, const char *label, t_boolean solid);
d_declare_method(landscape, set_item_active)(struct s_object *self, const char *label, t_boolean active);
d_declare_method(landscape, set_item_status)(struct s_object *self, const char *label, const char *status);
d_declare_method(landscape, get_dimension)(struct s_object *self, double *dimension_w, double *dimension_h);
d_declare_method(landscape, floor)(struct s_object *self, double position_x, double *position_y, double *dimension_h, double *scale_min, double *scale_max);
d_declare_method(landscape, validator)(struct s_object *self, struct s_object *entity, double current_x, double current_y, double *new_x, double *new_y,
                                       double *new_z, double camera_offset_x, double camera_offset_y, t_boolean collidator);
d_declare_method(landscape, update)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, delete)(struct s_object *self, struct s_landscape_attributes *attributes);
#endif
