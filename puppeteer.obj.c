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
#include "puppeteer.obj.h"
struct s_puppeteer_attributes *p_puppeteer_alloc(struct s_object *self) {
    struct s_puppeteer_attributes *result = d_prepare(self, puppeteer);
    f_memory_new(self);         /* inherit */
    f_mutex_new(self);          /* inherit */
    return result;
}

struct s_object *f_puppeteer_new(struct s_object *self, struct s_object *factory, t_entity_validator validator) {
    struct s_puppeteer_attributes *attributes = p_puppeteer_alloc(self);
    struct s_factory_attributes *factory_attributes = d_cast(factory, factory);
    struct s_puppeteer_character *current_character;
    struct s_object *json;
    char *name_buffer, *link_buffer;
    t_boolean controllable;
    int character_index = 0;
    attributes->factory = d_retain(factory);
    while ((d_call(factory_attributes->json_configuration, m_json_get_string, &name_buffer, "sds", "characters", character_index, "label"))) {
        controllable = d_false;
        d_call(factory_attributes->json_configuration, m_json_get_string, &link_buffer, "sds", "characters", character_index, "link");
        d_call(factory_attributes->json_configuration, m_json_get_boolean, &controllable, "sds", "characters", character_index, "controllable");
        if ((current_character = (struct s_puppeteer_character *) d_malloc(sizeof(struct s_puppeteer_character)))) {
            strncpy(current_character->label, name_buffer, d_entity_label_size);
            current_character->controllable = controllable;
            current_character->character = f_character_new(d_new(character), current_character->label, validator);
            if ((json = d_call(attributes->factory, m_factory_get_json, link_buffer))) {
                d_call(current_character->character, m_character_load, json, attributes->factory);
                d_call(current_character->character, m_controllable_set, controllable);
                d_delete(json);
            }
            f_list_append(&(attributes->characters), (struct s_list_node *)current_character, e_list_insert_head);
        } else
            d_die(d_error_malloc);
        ++character_index;
    }

    return self;
}

d_define_method(puppeteer, get_character)(struct s_object *self, const char *key) {
    d_using(puppeteer);
    struct s_puppeteer_character *current_character;
    struct s_object *result = NULL;
    d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character) {
        if (f_string_strcmp(current_character->label, key) == 0) {
            result = current_character->character;
            break;
        }
    }
    return result;
}

d_define_method(puppeteer, hide_characters)(struct s_object *self) {
    d_using(puppeteer);
    struct s_factory_attributes *factory_attributes = d_cast(puppeteer_attributes->factory, factory);
    struct s_puppeteer_character *current_character;
    d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)
        d_call(factory_attributes->environment, m_environment_del_drawable, current_character->character, d_puppeteer_default_layer, 
                e_environment_surface_primary);
    return self;
}

d_define_method(puppeteer, show_character)(struct s_object *self, const char *key, double position_x) {
    d_using(puppeteer);
    struct s_factory_attributes *factory_attributes = d_cast(puppeteer_attributes->factory, factory);
    struct s_object *current_character;
    if ((current_character = d_call(self, m_puppeteer_get_character, key))) {
        d_call(current_character, m_drawable_set_position_x, position_x);
        d_call(factory_attributes->environment, m_environment_add_drawable, current_character, d_puppeteer_default_layer, e_environment_surface_primary);
    }
    return self;
}

d_define_method(puppeteer, move_character)(struct s_object *self, const char *key, double destination_x) {
    d_using(puppeteer);
    struct s_factory_attributes *factory_attributes = d_cast(puppeteer_attributes->factory, factory);
    struct s_object *current_character;
    if ((current_character = d_call(self, m_puppeteer_get_character, key)))
        d_call(current_character, m_character_move, destination_x);
    return self;
}

d_define_method(puppeteer, delete)(struct s_object *self, struct s_puppeteer_attributes *attributes) {
    struct s_puppeteer_character *current_character;
    d_delete(attributes->factory);
    while ((current_character = (struct s_puppeteer_character *)((struct s_list_node *)attributes->characters.head))) {
        f_list_delete(&(attributes->characters), (struct s_list_node *)current_character);
        d_delete(current_character->character);
        d_free(current_character);
    }
    return NULL;
}

d_define_class(puppeteer) {
    d_hook_method(puppeteer, e_flag_public, get_character),
        d_hook_method(puppeteer, e_flag_public, hide_characters),
        d_hook_method(puppeteer, e_flag_public, show_character),
        d_hook_method(puppeteer, e_flag_public, move_character),
        d_hook_delete(puppeteer),
        d_hook_method_tail
};

