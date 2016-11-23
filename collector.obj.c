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
#include "collector.obj.h"
#include "director.obj.h"
struct s_lisp_object *p_link_collector_set(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    struct s_lisp_object *label_object = d_lisp_car(arguments), 
                         *value_object = d_lisp_cadr(arguments);
    struct s_director_attributes *director_attributes = d_cast(director, director);
    if (label_object->type == e_lisp_object_type_string) {
        if (value_object->type == e_lisp_object_type_string)
            d_call(director_attributes->collector, m_collector_add_entry_string, label_object->value_string, value_object->value_string);
        else if (value_object->type == e_lisp_object_type_symbol)
            d_call(director_attributes->collector, m_collector_add_entry_string, label_object->value_string, value_object->value_symbol);
        else if (value_object->type == e_lisp_object_type_value)
            d_call(director_attributes->collector, m_collector_add_entry_double, label_object->value_string, value_object->value_double);
    }
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_collector_get(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    struct s_lisp_object *label_object = d_lisp_car(arguments), *result = lisp_attributes->base_symbols[e_lisp_object_symbol_nil];
    struct s_director_attributes *director_attributes = d_cast(director, director);
    struct s_collector_entry *current_entry;
    if (label_object->type == e_lisp_object_type_string)
        if ((current_entry = (struct s_collector_entry *) d_call(director_attributes->collector, m_collector_get_entry, label_object->value_string))) {
            if (current_entry->type == e_collector_type_string)
                result = p_lisp_object(self, e_lisp_object_type_string, d_false, current_entry->value.value_string);
            else if (current_entry->type == e_collector_type_double)
                result = p_lisp_object(self, e_lisp_object_type_value, d_false, current_entry->value.value_double);
        }
    return result;
}

struct s_collector_attributes *p_collector_alloc(struct s_object *self) {
    struct s_collector_attributes *result = d_prepare(self, collector);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_collector_new(struct s_object *self) {
    struct s_collector_attributes *attributes = p_collector_alloc(self);
    FILE *collector_dump = fopen(d_collector_dump, "r");
    char buffer[d_string_buffer_size], *ptr_name, *ptr_type, *ptr_data;
    if (collector_dump) {
        while (fgets(buffer, d_string_buffer_size, collector_dump)) {
            ptr_name = buffer;
            f_string_trim(ptr_name);
            if ((ptr_type = strchr(ptr_name, ':'))) {
                *ptr_type = 0;
                ++ptr_type;
                if ((ptr_data = strchr(ptr_type, ':'))) {
                    *ptr_data = 0;
                    ++ptr_data;
                    if (f_string_strcmp(ptr_type, d_collector_dump_string) == 0)
                        d_call(self, m_collector_add_entry_string, ptr_name, ptr_data);
                    else if (f_string_strcmp(ptr_type, d_collector_dump_double) == 0)
                        d_call(self, m_collector_add_entry_double, ptr_name, (double)atof(ptr_data));
                }
            }
        }
        fclose(collector_dump);
    }
    return self;
}

d_define_method(collector, get_entry)(struct s_object *self, const char *key) {
    d_using(collector);
    struct s_collector_entry *current_entry;
    d_foreach(&(collector_attributes->pool), current_entry, struct s_collector_entry)
        if (f_string_strcmp(current_entry->key, key) == 0)
            break;
    d_cast_return(current_entry);
}

d_define_method(collector, add_entry)(struct s_object *self, const char *key) {
    d_using(collector);
    struct s_collector_entry *current_entry;
    if ((current_entry = d_call(self, m_collector_get_entry, key))) {
        if ((current_entry->type == e_collector_type_string) && (current_entry->value.value_string)) {
            d_free(current_entry->value.value_string);
            current_entry->value.value_string = NULL;
        }
    } else if ((current_entry = (struct s_collector_entry *)d_malloc(sizeof(struct s_collector_entry)))) {
        f_list_append(&(collector_attributes->pool), (struct s_list_node *)current_entry, e_list_insert_head);
        strncpy(current_entry->key, key, d_lisp_symbol_size);
    }
    d_cast_return(current_entry);
}

d_define_method(collector, add_entry_double)(struct s_object *self, const char *key, double value) {
    struct s_collector_entry *current_entry = d_call(self, m_collector_add_entry, key);
    current_entry->type = e_collector_type_double;
    current_entry->value.value_double = value;
    return self;
}

d_define_method(collector, add_entry_string)(struct s_object *self, const char *key, const char *value) {
    struct s_collector_entry *current_entry = d_call(self, m_collector_add_entry, key);
    current_entry->type = e_collector_type_string;
    if (value)
        if ((current_entry->value.value_string = (char *)d_malloc(f_string_strlen(value)+1)))
            strcpy(current_entry->value.value_string, value);
    return self;
}

d_define_method(collector, linker)(struct s_object *self, struct s_object *script) {
    d_call(script, m_lisp_extend_environment, "collector_set", p_lisp_object(script, e_lisp_object_type_primitive, p_link_collector_set));
    d_call(script, m_lisp_extend_environment, "collector_get", p_lisp_object(script, e_lisp_object_type_primitive, p_link_collector_get));
    return self;
}

d_define_method(collector, delete)(struct s_object *self, struct s_collector_attributes *attributes) {
    struct s_collector_entry *current_entry;
    FILE *collector_dump = fopen(d_collector_dump, "w");
    while ((current_entry = (struct s_collector_entry *)attributes->pool.head)) {
        f_list_delete(&(attributes->pool), (struct s_list_node *)current_entry);
        if (collector_dump)
            switch (current_entry->type) {
                case e_collector_type_string:
                    fprintf(collector_dump, "%s:%s:%s\n", current_entry->key, d_collector_dump_string, current_entry->value.value_string);
                    break;
                case e_collector_type_double:
                    fprintf(collector_dump, "%s:%s:%.02f\n", current_entry->key, d_collector_dump_double, current_entry->value.value_double);
                    break;
            }
        if ((current_entry->type == e_collector_type_string) && (current_entry->value.value_string))
            d_free(current_entry->value.value_string);
        d_free(current_entry);
    }
    if (collector_dump)
        fclose(collector_dump);
    return NULL;
}

d_define_class(collector) {
    d_hook_method(collector, e_flag_public, get_entry),
        d_hook_method(collector, e_flag_private, add_entry),
        d_hook_method(collector, e_flag_public, add_entry_double),
        d_hook_method(collector, e_flag_public, add_entry_string),
        d_hook_method(collector, e_flag_public, linker),
        d_hook_delete(collector),
        d_hook_method_tail
};
