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
#ifndef pomodoro_director_h
#define pomodoro_director_h
#include "puppeteer.obj.h"
#include "effecteer.obj.h"
#include "camera.obj.h"
extern struct s_object *director;
/* action definition */
typedef enum e_director_actions { 
    e_director_action_puppeteer,
    e_director_action_effecteer,
    e_director_action_service_sleep,
    e_director_action_service_script,
    e_director_action_service_camera_move,
    e_director_action_service_camera_follow
} e_director_actions;
typedef struct s_director_action_camera_move {
    double position_x, position_y, position_z;
} s_director_action_camera_move;
typedef struct s_director_action_camera_follow {
    char key[d_entity_label_size];
    double position_y, position_z;
} s_director_action_camera_follow;
typedef struct s_director_action { d_list_node_head;
    enum e_director_actions type;
    time_t creation_time, pushing_time, execution_time;
    union {
        time_t delay;
        char label[d_resources_key_size];
        struct s_director_action_camera_move camera_move;
        struct s_director_action_camera_follow camera_follow;
        struct s_puppeteer_action character;
        struct s_effecteer_action effect;
    } action;
} s_director_action;
extern struct s_lisp_object *p_link_director_sleep(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_director_script(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_director_camera_move(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_director_camera_follow(struct s_object *self, struct s_lisp_object *arguments);
/* end */
d_declare_class(director) {
    struct s_attributes head;
    struct s_list actions_pool;
    struct s_object *factory;
    struct s_object *camera;
    struct s_object *puppeteer;
    struct s_object *effecteer;
    time_t alive;
} d_declare_class_tail(director);
extern t_boolean f_director_validator(struct s_object *self, double current_x, double current_y, double current_zoom, double *new_x, double *new_y, 
        double *new_zoom);
struct s_director_attributes *p_director_alloc(struct s_object *self);
extern struct s_object *f_director_new(struct s_object *self, struct s_object *factory);
d_declare_method(director, new_action)(struct s_object *self, enum e_director_actions type);
d_declare_method(director, push_action)(struct s_object *self, struct s_director_action *action);
d_declare_method(director, update)(struct s_object *self);
d_declare_method(director, run_script)(struct s_object *self, const char *label);
d_declare_method(director, linker)(struct s_object *self, struct s_object *script);
d_declare_method(director, dispatcher)(struct s_object *self, struct s_director_action *action);
d_declare_method(director, delete)(struct s_object *self, struct s_director_attributes *attributes);
#endif