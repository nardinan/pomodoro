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
#include "camera.obj.h"
struct s_camera_attributes *p_camera_alloc(struct s_object *self) {
    struct s_camera_attributes *result = d_prepare(self, camera);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_camera_new(struct s_object *self, enum e_environment_surfaces surface) {
    struct s_camera_attributes *attributes = p_camera_alloc(self);
    attributes->initial_speed = d_camera_default_initial_speed;
    attributes->final_speed = d_camera_default_final_speed;
    attributes->surface = surface;
    return self;
}

d_define_method(camera, move_position)(struct s_object *self, double position_x, double position_y, double position_z, struct s_object *environment) {
    d_using(camera);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    double real_position_x, real_position_y;
    if (camera_attributes->distance_xy == 0)
        gettimeofday(&(camera_attributes->last_refresh), NULL);
    camera_attributes->starting_x = environment_attributes->camera_origin_x[camera_attributes->surface];
    camera_attributes->starting_y = environment_attributes->camera_origin_y[camera_attributes->surface];
    camera_attributes->starting_z = environment_attributes->zoom[camera_attributes->surface];
    real_position_x = position_x * (environment_attributes->current_w / environment_attributes->reference_w[camera_attributes->surface]);
    real_position_y = position_y * (environment_attributes->current_h / environment_attributes->reference_h[camera_attributes->surface]);
    camera_attributes->destination_x = (real_position_x - (environment_attributes->current_w / 2.0));
    camera_attributes->destination_y = (real_position_y - (environment_attributes->current_h / 2.0));
    if (position_z == position_z)
        camera_attributes->destination_z = position_z;
    camera_attributes->distance_xy = sqrt((d_math_square(camera_attributes->destination_x - camera_attributes->starting_x) + 
                d_math_square(camera_attributes->destination_y - camera_attributes->starting_y)));
    return self;
}

d_define_method(camera, set_position)(struct s_object *self, double position_x, double position_y, double position_z, struct s_object *environment) {
    d_using(camera);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    camera_attributes->destination_x = (position_x - (environment_attributes->current_w / 2.0));
    camera_attributes->destination_y = (position_y - (environment_attributes->current_h / 2.0));
    if (position_z == position_z)
        camera_attributes->destination_z = position_z;
    camera_attributes->starting_x = camera_attributes->destination_x;
    camera_attributes->starting_y = camera_attributes->destination_y;
    camera_attributes->starting_z = camera_attributes->destination_z;
    camera_attributes->distance_xy = 0.0;
    d_call(environment, m_environment_set_camera, camera_attributes->destination_x, camera_attributes->destination_y, camera_attributes->surface);
    d_call(environment, m_environment_set_zoom, camera_attributes->destination_z, camera_attributes->surface);
    return self;
}


d_define_method(camera, move_reference)(struct s_object *self, struct s_object *reference, double offset_x, double offset_y, double position_z,
        struct s_object *environment) {
    double position_x, position_y;
    d_call(reference, m_drawable_get_position, &position_x, &position_y);
    return d_call(self, m_camera_move_position, (position_x + offset_x), (position_y + offset_y), position_z, environment);
}

d_define_method(camera, chase_reference)(struct s_object *self, struct s_object *reference, double offset_x, double offset_y, double position_z,
        struct s_object *environment) {
    d_using(camera);
    if (camera_attributes->reference)
        d_delete(camera_attributes->reference);
    camera_attributes->reference = d_retain(reference);
    camera_attributes->offset_x = offset_x;
    camera_attributes->offset_y = offset_y;
    if (position_z == position_z)
        camera_attributes->destination_z = position_z;
    return self;
}

d_define_method(camera, remove_reference)(struct s_object *self) {
    d_using(camera);
    if (camera_attributes->reference) {
        d_delete(camera_attributes->reference);
        camera_attributes->reference = NULL;
    }
    return self;
}

d_define_method(camera, set_speed)(struct s_object *self, double speed) {
    d_using(camera);
    camera_attributes->initial_speed = speed;
    camera_attributes->final_speed = speed;
    return self;
}

d_define_method(camera, set_initial_speed)(struct s_object *self, double speed) {
    d_using(camera);
    camera_attributes->initial_speed = speed;
    return self;
}

d_define_method(camera, set_final_speed)(struct s_object *self, double speed) {
    d_using(camera);
    camera_attributes->final_speed = speed;
    return self;
}

d_define_method(camera, update)(struct s_object *self, struct s_object *environment) {
    d_using(camera);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    struct timeval current, difference;
    double camera_position_x, camera_position_y, camera_position_z, current_distance, percentage_current_distance, percentage_movement, 
           difference_seconds, t, final_position_x = 0.0, final_position_y = 0.0, final_position_z = 0.0;
    if (camera_attributes->reference)
        d_call(self, m_camera_move_reference, camera_attributes->reference, camera_attributes->offset_x, camera_attributes->offset_y, NAN, environment);
    gettimeofday(&current, NULL);
    camera_position_x = environment_attributes->camera_origin_x[camera_attributes->surface];
    camera_position_y = environment_attributes->camera_origin_y[camera_attributes->surface];
    camera_position_z = environment_attributes->zoom[camera_attributes->surface];
    if (camera_attributes->distance_xy > 0.0) {
        timersub(&current, &(camera_attributes->last_refresh), &difference);
        difference_seconds = difference.tv_sec + ((double)(difference.tv_usec)/1000000.0);
        current_distance = sqrt(d_math_square(camera_position_x - camera_attributes->destination_x) + 
                d_math_square(camera_position_y - camera_attributes->destination_y));
        percentage_current_distance = (1.0 / camera_attributes->distance_xy) * (camera_attributes->distance_xy - current_distance);
        if ((percentage_movement = d_math_min(1.0, (camera_attributes->final_speed + ((camera_attributes->initial_speed - camera_attributes->final_speed) * 
                                (1.0 - percentage_current_distance))) * difference_seconds)) > 0.0) {   
            t = ((camera_attributes->distance_xy * (percentage_current_distance + percentage_movement))/camera_attributes->distance_xy);
            final_position_x = ((1.0 - t) * camera_attributes->starting_x) + (t * camera_attributes->destination_x);
            final_position_y = ((1.0 - t) * camera_attributes->starting_y) + (t * camera_attributes->destination_y);
            final_position_z = camera_attributes->starting_z + ((camera_attributes->destination_z - camera_attributes->starting_z) *
                    (d_math_min(1.0, (percentage_current_distance + percentage_movement))));
            d_camera_round(camera_attributes->destination_x, final_position_x, 1.0);
            d_camera_round(camera_attributes->destination_y, final_position_y, 1.0);
            d_camera_round(camera_attributes->destination_z, final_position_z, 0.001);
            if ((camera_attributes->destination_x == final_position_x) &&
                    (camera_attributes->destination_y == final_position_y) &&
                    (camera_attributes->destination_z == final_position_z))
                camera_attributes->distance_xy = 0;
            d_call(environment, m_environment_set_camera, final_position_x, final_position_y, camera_attributes->surface);
            d_call(environment, m_environment_set_zoom, final_position_z, camera_attributes->surface);
            memcpy(&(camera_attributes->last_refresh), &current, sizeof(struct timeval));
        }
    }
    return self;
}


d_define_method(camera, delete)(struct s_object *self, struct s_camera_attributes *attributes) {
    if (attributes->reference)
        d_delete(attributes->reference);
    return NULL;
}

d_define_class(camera) {
    d_hook_method(camera, e_flag_public, move_position),
        d_hook_method(camera, e_flag_public, set_position),
        d_hook_method(camera, e_flag_public, move_reference),
        d_hook_method(camera, e_flag_public, chase_reference),
        d_hook_method(camera, e_flag_public, remove_reference),
        d_hook_method(camera, e_flag_public, set_speed),
        d_hook_method(camera, e_flag_public, set_initial_speed),
        d_hook_method(camera, e_flag_public, set_final_speed),
        d_hook_method(camera, e_flag_public, update),
        d_hook_delete(camera),
        d_hook_method_tail
};
