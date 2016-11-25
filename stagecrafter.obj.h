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
#ifndef pomodoro_stagecrafter_h
#define pomodoro_stagecrafter_h
#include "landscape.obj.h"
/* action definition */
typedef enum e_stagecrafter_actions {
    e_stagecrafter_action_hide,
    e_stagecrafter_action_show,
    e_stagecrafter_action_stop,
    e_stagecrafter_action_play,
    e_stagecrafter_action_lock,
    e_stagecrafter_action_unlock,
    e_stagecrafter_action_enable,
    e_stagecrafter_action_disable,
    e_stagecrafter_action_set
} e_stagecrafter_actions;
typedef struct s_stagecrafter_action {
    enum e_stagecrafter_actions type;
    char key[d_entity_label_size];
    union {
        char entry[d_string_buffer_size];
    } parameters;
} s_stagecrafter_action;
extern struct s_lisp_object *p_link_stagecrafter_hide_landscapes(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_show_landscape(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_stop_track(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_play_track(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_lock_item(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_unlock_item(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_enable_item(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_disable_item(struct s_object *self, struct s_lisp_object *arguments);
extern struct s_lisp_object *p_link_stagecrafter_set_item(struct s_object *self, struct s_lisp_object *arguments);
/* end */
typedef struct s_stagecrafter_landscape { d_list_node_head;
    char label[d_entity_label_size];
    struct s_object *landscape;
} s_stagecrafter_landscape;
d_declare_class(stagecrafter) {
    struct s_attributes head;
    struct s_object *factory;
    struct s_list landscapes;
    struct s_object *main_landscape;
} d_declare_class_tail(stagecrafter);
struct s_stagecrafter_attributes *p_stagecrafter_alloc(struct s_object *self);
extern struct s_object *f_stagecrafter_new(struct s_object *self, struct s_object *factory);
d_declare_method(stagecrafter, get_landscape)(struct s_object *self, const char *key);
d_declare_method(stagecrafter, hide_landscapes)(struct s_object *self);
d_declare_method(stagecrafter, show_landscape)(struct s_object *self, const char *key);
d_declare_method(stagecrafter, get_main_landscape)(struct s_object *self);
d_declare_method(stagecrafter, stop_tracks)(struct s_object *self);
d_declare_method(stagecrafter, play_track)(struct s_object *self, const char *key);
d_declare_method(stagecrafter, set_item_solid)(struct s_object *self, const char *key, t_boolean solid);
d_declare_method(stagecrafter, set_item_active)(struct s_object *self, const char *key, t_boolean active);
d_declare_method(stagecrafter, set_item_status)(struct s_object *self, const char *key, const char *status);
d_declare_method(stagecrafter, update)(struct s_object *self);
d_declare_method(stagecrafter, linker)(struct s_object *self, struct s_object *script);
d_declare_method(stagecrafter, dispatcher)(struct s_object *self, struct s_stagecrafter_action *action);
d_declare_method(stagecrafter, delete)(struct s_object *self, struct s_stagecrafter_attributes *attributes);
#endif
