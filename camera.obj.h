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
#ifndef pomodoro_camera_h
#define pomodoro_camera_h
#include "miranda.h"
#include <sys/time.h>
#include <math.h>
#define d_camera_default_initial_speed  0.8
#define d_camera_default_final_speed    0.01
#define d_camera_round(o, v, t) do{\
    if((((o)-(t))<(v))&&(((o)+(t))>(v)))\
        (v)=(o);\
}while(0)
d_declare_class(camera) {
  struct s_attributes head;
  double destination_x, destination_y, destination_z, starting_x, starting_y, starting_z, offset_x, offset_y, distance_xy, initial_speed, final_speed,
    low_limit_x, high_limit_x, low_limit_y, high_limit_y;
  enum e_environment_surfaces surface;
  struct s_object *reference;
  struct timeval last_refresh;
  t_boolean limit_x, limit_y;
} d_declare_class_tail(camera);
struct s_camera_attributes *p_camera_alloc(struct s_object *self);
extern struct s_object *f_camera_new(struct s_object *self, enum e_environment_surfaces surface);
d_declare_method(camera, move_position)(struct s_object *self, double position_x, double position_y, double position_z, struct s_object *environment);
d_declare_method(camera, set_position)(struct s_object *self, double position_x, double position_y, double position_z, struct s_object *environment);
d_declare_method(camera, move_reference)(struct s_object *self, struct s_object *reference, double offset_x, double offset_y, double position_z,
                                         struct s_object *environment);
d_declare_method(camera, chase_reference)(struct s_object *self, struct s_object *reference, double offset_x, double offset_y, double position_z,
                                          struct s_object *environment);
d_declare_method(camera, remove_reference)(struct s_object *self);
d_declare_method(camera, set_speed)(struct s_object *self, double speed);
d_declare_method(camera, set_limit_x)(struct s_object *self, t_boolean applied, double low_limit_x, double high_limit_x);
d_declare_method(camera, set_limit_y)(struct s_object *self, t_boolean applied, double low_limit_y, double high_limit_y);
d_declare_method(camera, set_initial_speed)(struct s_object *self, double speed);
d_declare_method(camera, set_final_speed)(struct s_object *self, double speed);
d_declare_method(camera, update)(struct s_object *self, struct s_object *environment);
d_declare_method(camera, delete)(struct s_object *self, struct s_camera_attributes *attributes);
#endif
