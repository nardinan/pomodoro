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
#ifndef pomodoro_module_configuration_h
#define pomodoro_module_configuration_h
#include "collector.obj.h"
#include "factory.obj.h"
d_declare_class(module_configuration) {
    struct s_attributes head;
    struct s_object *ui_factory;
    struct s_object *resources_json;
    struct s_object *resources_png;
} d_declare_class_tail(module_configuration);
struct s_module_configuration_attributes *p_module_configuration_alloc(struct s_object *self);
extern struct s_object *f_module_configuration_new(struct s_object *self, struct s_object *environment, struct s_object *resources_json, 
        struct s_object *resources_png, struct s_object *ui_factory);
d_declare_method(module_configuration, fill_resources)(struct s_object *self, struct s_object *environment);
d_declare_method(module_configuration, get_resolution)(struct s_object *self, double *width, double *height);
d_declare_method(module_configuration, get_language)(struct s_object *self, double *language);
d_declare_method(module_configuration, get_volume)(struct s_object *self, double *volume);
d_declare_method(module_configuration, get_fullscreen)(struct s_object *self, t_boolean *fullscreen);
d_declare_method(module_configuration, get_uiable)(struct s_object *self, struct s_object *environment);
d_declare_method(module_configuration, delete)(struct s_object *self, struct s_module_configuration_attributes *attributes);
extern void p_module_configuration_reset(struct s_object *self, void **parameters, size_t entries);
extern void p_module_configuration_apply(struct s_object *self, void **parameters, size_t entries);
#endif
