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
#include "loader.obj.h"
struct s_loader_attributes *p_loader_alloc(struct s_object *self) {
    struct s_loader_attributes *result = d_prepare(self, loader);
    f_memory_new(self);     /* inherit */
    f_mutex_new(self);      /* inherit */
    f_runnable_new(self);   /* inherit */
    return result;
}

struct s_object *f_loader_new(struct s_object *self) {
    struct s_loader_attributes *attributes = p_loader_alloc(self);
    attributes = attributes;
    return self;
}

d_define_method_override(loader, job)(struct s_object *self) {
    while (!d_call(self, m_runnable_kill_required, NULL)) {
        /* here loading code */
    }
    return self;
}

d_define_class(loader) {
    d_hook_method_override(loader, e_flag_public, runnable, job),
        d_hook_method_tail
};
