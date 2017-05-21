/*
 * pomodoro
 * Copyright (C) 2017 Andrea Nardinocchi (andrea@nardinan.it)
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
#ifndef pomodoro_loader_h
#define pomodoro_loader_h
#include "miranda.h"
d_declare_class(loader) {
    struct s_attributes head;
} d_declare_class_tail(loader);
struct s_loader_attributes *p_loader_alloc(struct s_object *self);
extern struct s_object *f_loader_new(struct s_object *self);
d_declare_method(loader, run)(struct s_object *self);
#endif
