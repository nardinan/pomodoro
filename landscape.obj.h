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
typedef struct s_landscape_surface { d_list_node_head;
    struct s_object *drawable;
    double offset_x, offset_y, speed_ratio_x, speed_ratio_y;
    int layer;
} s_landscape_surface;
typedef struct s_landscape_point { d_list_node_head;
    double position_x, position_y;
} s_landscape_point;
d_declare_class(landscape) {
    struct s_attributes head;
    char label[d_entity_label_size];
    struct s_list surfaces, points;
    double position_x, position_y;
} d_declare_class_tail(landscape);
struct s_landscape_attributes *p_landscape_alloc(struct s_object *self);
extern struct s_object *f_landscape_new(struct s_object *self, const char *key);
d_declare_method(landscape, load)(struct s_object *self, struct s_object *json, struct s_object *factory);
d_declare_method(landscape, show)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, hide)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, get_floor)(struct s_object *self, double position_x, double *position_y);
d_declare_method(landscape, update)(struct s_object *self, struct s_object *environment);
d_declare_method(landscape, delete)(struct s_object *self, struct s_landscape_attributes *attributes);
#endif
