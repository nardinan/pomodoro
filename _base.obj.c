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
#include "_base.obj.h"
struct s_#tag_attributes *p_#tag_alloc(struct s_object *self) {
    struct s_#tag_attributes *result = d_prepare(self, #tag);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_#tag_new(struct s_object *self) {
    struct s_#tag_attributes *attributes = p_#tag_alloc(self);
    attributes = attributes;
    return self;
}

d_define_method(#tag, delete)(struct s_object *self, struct s_#tag_attributes *attributes) {
    return NULL;
}

d_define_class(#tag) {
        d_hook_delete(#tag),
        d_hook_method_tail
};
