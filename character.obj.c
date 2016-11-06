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
#include "character.obj.h"
const char *v_character_components_label[e_character_component_NULL] = {
    "hair",
    "eyes",
    "head",
    "arms",
    "legs",
    "body",
}, *v_character_directions_label[e_character_direction_NULL] = {
    "left",
    "right",
    "up",
    "down"
};
struct s_character_attributes *p_character_alloc(struct s_object *self, const char *key, t_entity_validator validator) {
    struct s_character_attributes *result = d_prepare(self, character);
    f_memory_new(self);                 /* inherit */
    f_mutex_new(self);                  /* inherit */
    f_entity_new(self, key, validator); /* inherit */
    f_controllable_new(self);           /* inherit */
    return result;
}

struct s_object *f_character_new(struct s_object *self, const char *key, t_entity_validator validator) {
    struct s_character_attributes *attributes = p_character_alloc(self, key, validator);
    d_call(self, m_controllable_add_configuration, SDLK_LEFT,   p_character_move_left,  p_character_move_left,  d_true);
    d_call(self, m_controllable_add_configuration, SDLK_RIGHT,  p_character_move_right, p_character_move_right, d_true);
    d_call(self, m_controllable_add_configuration, SDLK_UP,     p_character_move_up,    p_character_move_up,    d_true);
    d_call(self, m_controllable_add_configuration, SDLK_DOWN,   p_character_move_down,  p_character_move_down,  d_true);
    attributes->movement = d_false;
    attributes->direction = e_character_direction_down;
    attributes->set = d_true;
    return self;
}

d_define_method(character, load)(struct s_object *self, struct s_object *json, struct s_object *factory) {
    d_using(character);
    struct s_object *drawable;
    enum e_drawable_flips flips;
    enum e_factory_media_types type;
    char *string_supply, *string_supply_component;
    t_boolean status_flip_x = d_false, status_flip_y = d_false, character_flip_x, character_flip_y;
    double offset_x, offset_y, mask_R = 255.0, mask_G = 255.0, mask_B = 255.0, mask_A = 255.0, zoom = 1.0, speed_x, speed_y, speed_z;
    int index_status = 0, index_component;
    if (d_call(json, m_json_get_string, &string_supply, "s", "format")) {
        if (f_string_strcmp(string_supply, "character") == 0)
            if ((d_call(json, m_json_get_string, &string_supply, "s", "ID"))) {
                d_call(json, m_json_get_double, &mask_R, "ss", "bubble", "mask_R");
                d_call(json, m_json_get_double, &mask_G, "ss", "bubble", "mask_G");
                d_call(json, m_json_get_double, &mask_B, "ss", "bubble", "mask_B");
                d_call(json, m_json_get_double, &mask_A, "ss", "bubble", "mask_A");
                d_call(json, m_json_get_double, &(character_attributes->bubble_offset_x), "ss", "bubble", "offset_x");
                d_call(json, m_json_get_double, &(character_attributes->bubble_offset_y), "ss", "bubble", "offset_y");
                if (character_attributes->bubble)
                    d_delete(character_attributes->bubble);
                d_assert(character_attributes->bubble = f_bubble_new(d_new(bubble), factory, (unsigned int)mask_R, (unsigned int)mask_G, (unsigned int)mask_B, 
                            (unsigned int)mask_A, TTF_STYLE_NORMAL));
                d_call(json, m_json_get_boolean, &status_flip_x, "s", "flip_x");
                d_call(json, m_json_get_boolean, &status_flip_y, "s", "flip_y");
                d_call(json, m_json_get_double, &zoom, "s", "zoom");
                while (d_call(json, m_json_get_string, &string_supply_component, "sds", "statuses", index_status, "label")) {
                    speed_x = 0;
                    speed_y = 0;
                    speed_z = 0;
                    d_call(json, m_json_get_double, &speed_x, "sds", "statuses", index_status, "speed_x");
                    d_call(json, m_json_get_double, &speed_y, "sds", "statuses", index_status, "speed_y");
                    d_call(json, m_json_get_double, &speed_z, "sds", "statuses", index_status, "speed_z");
                    d_call(self, m_entity_add_component, string_supply_component, speed_x, speed_y, speed_z);
                    for (index_component = 0; index_component < e_character_component_NULL; ++index_component) {
                        offset_x = 0;
                        offset_y = 0;
                        character_flip_x = status_flip_x;
                        character_flip_y = status_flip_y;
                        mask_R = 255.0;
                        mask_G = 255.0;
                        mask_B = 255.0;
                        mask_A = 255.0;
                        if ((d_call(json, m_json_get_string, &string_supply, "sdss", "statuses", index_status, 
                                        v_character_components_label[index_component], "drawable"))) {
                            d_call(json, m_json_get_double, &offset_x, "sdss", "statuses", index_status,
                                    v_character_components_label[index_component], "offset_x");
                            d_call(json, m_json_get_double, &offset_y, "sdss", "statuses", index_status,
                                    v_character_components_label[index_component], "offset_y");
                            d_call(json, m_json_get_boolean, &character_flip_x, "sdss", "statuses", index_status, 
                                    v_character_components_label[index_component], "flip_x");
                            d_call(json, m_json_get_boolean, &character_flip_y, "sdss", "statuses", index_status,
                                    v_character_components_label[index_component], "flip_y");
                            d_call(json, m_json_get_double, &mask_R, "sdss", "statuses", index_status, v_character_components_label[index_component], "mask_R");
                            d_call(json, m_json_get_double, &mask_G, "sdss", "statuses", index_status, v_character_components_label[index_component], "mask_G");
                            d_call(json, m_json_get_double, &mask_B, "sdss", "statuses", index_status, v_character_components_label[index_component], "mask_B");
                            d_call(json, m_json_get_double, &mask_A, "sdss", "statuses", index_status, v_character_components_label[index_component], "mask_A");
                            if ((drawable = d_call(factory, m_factory_get_media, string_supply, &type))) {
                                if ((character_flip_x) && (character_flip_y))
                                    flips = e_drawable_flip_both;
                                else if (character_flip_x)
                                    flips = e_drawable_flip_horizontal;
                                else if (character_flip_y)
                                    flips = e_drawable_flip_vertical;
                                else
                                    flips = e_drawable_flip_none;
                                d_call(drawable, m_drawable_flip, flips);
                                d_call(drawable, m_drawable_set_maskRGB, (unsigned int)mask_R, (unsigned int)mask_G, (unsigned int)mask_B);
                                d_call(drawable, m_drawable_set_maskA, (unsigned int)mask_A);
                                d_call(self, m_entity_add_element, string_supply_component, offset_x, offset_y, drawable);
                                d_delete(drawable);
                            }
                        }
                    }
                    ++index_status;
                }
                d_call(self, m_drawable_set_zoom, zoom);
            }
        /* character initialization */
        d_call(self, m_character_move_down, NULL, d_false);
    }
    return self;
}

d_define_method_override(character, set_component)(struct s_object *self, char *label) {
    struct s_entity_attributes *entity_attributes = d_cast(self, entity);
    struct s_animation_attributes *animation_attributes;
    struct s_entity_element *current_element;
    struct s_object *result = d_call_owner(self, entity, m_entity_set_component, label);
    if (entity_attributes->current_component)
        d_foreach(&(entity_attributes->current_component->elements), current_element, struct s_entity_element)
            if ((animation_attributes = d_cast(current_element->drawable, animation))) {
                d_call(current_element->drawable, m_animation_set_status, e_animation_direction_stop);
                d_call(current_element->drawable, m_animation_set_status, e_animation_direction_forward);
            }
    return result;
}

d_define_method(character, move_left)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
    d_using(character);
    if (pressed) {
        d_call(self, m_entity_set_component, "walk_left");
        character_attributes->direction = e_character_direction_left;
        character_attributes->movement = d_true;
    } else {
        d_call(self, m_entity_set_component, "still_left");
        character_attributes->movement = d_false;
    }
    character_attributes->set = d_true;
    return self;
}

d_define_method(character, move_right)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
    d_using(character);
    if (pressed) {
        d_call(self, m_entity_set_component, "walk_right");
        character_attributes->direction = e_character_direction_right;
        character_attributes->movement = d_true;
    } else {
        d_call(self, m_entity_set_component, "still_right");
        character_attributes->movement = d_false;
    }
    character_attributes->set = d_true;
    return self;
}

d_define_method(character, move_up)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
    d_using(character);
    d_call(self, m_entity_set_component, "back");
    character_attributes->direction = e_character_direction_up;
    character_attributes->movement = d_false;
    character_attributes->set = d_true;
    return self;
}

d_define_method(character, move_down)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
    d_using(character);
    d_call(self, m_entity_set_component, "front");
    character_attributes->direction = e_character_direction_down;
    character_attributes->movement = d_false;
    character_attributes->set = d_true;
    return self;
}

d_define_method(character, say)(struct s_object *self, const char *message, time_t timeout) {
    d_using(character);
    if (character_attributes->bubble)
        d_call(character_attributes->bubble, m_bubble_add_message, message, timeout, d_character_default_font);
    return self;
}

d_define_method(character, move)(struct s_object *self, double destination_x) {
    d_using(character);
    double position_x, position_y;
    d_call(self, m_drawable_get_position, &position_x, &position_y);
    character_attributes->destination_x = destination_x;
    character_attributes->source_x = position_x;
    if (destination_x != position_x)
        d_call(self, (destination_x > position_x)?m_character_move_right:m_character_move_left, NULL, d_true);
    return self;
}

d_define_method_override(character, draw)(struct s_object *self, struct s_object *environment) {
    d_using(character);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    struct s_drawable_attributes *drawable_attributes_self = d_cast(self, drawable),
                                 *drawable_attributes_bubble;
    double position_x, position_y, bubble_position_x, bubble_position_y;
    struct s_object *result = d_call_owner(self, entity, m_drawable_draw, environment); /* recall the father's draw method */
    d_call(self, m_drawable_get_position, &position_x, &position_y);
    if (((character_attributes->source_x < character_attributes->destination_x) && (position_x >= character_attributes->destination_x)) ||
            ((character_attributes->source_x > character_attributes->destination_x) && (position_x <= character_attributes->destination_x))) {
        d_call(self, (character_attributes->destination_x > character_attributes->source_x)?m_character_move_right:m_character_move_left, NULL, d_false);
        character_attributes->source_x = character_attributes->destination_x;
    }
    if (character_attributes->bubble) {
        drawable_attributes_bubble = d_cast(character_attributes->bubble, drawable);
        bubble_position_x = position_x + (character_attributes->bubble_offset_x * drawable_attributes_self->zoom);
        bubble_position_y = position_y + (character_attributes->bubble_offset_y * drawable_attributes_self->zoom);
        d_call(character_attributes->bubble, m_drawable_set_position, bubble_position_x, bubble_position_y);
        drawable_attributes_bubble->angle = drawable_attributes_self->angle;
        drawable_attributes_bubble->zoom = drawable_attributes_self->zoom;
        drawable_attributes_bubble->flip = drawable_attributes_self->flip;
        if ((d_call(character_attributes->bubble, m_drawable_normalize_scale, environment_attributes->reference_w[environment_attributes->current_surface],
                        environment_attributes->reference_h[environment_attributes->current_surface],
                        environment_attributes->camera_origin_x[environment_attributes->current_surface],
                        environment_attributes->camera_origin_y[environment_attributes->current_surface],
                        environment_attributes->camera_focus_x[environment_attributes->current_surface],
                        environment_attributes->camera_focus_y[environment_attributes->current_surface],
                        environment_attributes->current_w,
                        environment_attributes->current_h,
                        environment_attributes->zoom[environment_attributes->current_surface])))
            while(((int)d_call(character_attributes->bubble, m_drawable_draw, environment)) == d_drawable_return_continue);
    }
    return result;
}

d_define_method(character, delete)(struct s_object *self, struct s_character_attributes *attributes) {
    if (attributes->bubble)
        d_delete(attributes->bubble);
    return NULL;
}

d_define_class(character) {
    d_hook_method(character, e_flag_public, load),
        d_hook_method_override(character, e_flag_public, entity, set_component),
        d_hook_method(character, e_flag_public, move_left),
        d_hook_method(character, e_flag_public, move_right),
        d_hook_method(character, e_flag_public, move_up),
        d_hook_method(character, e_flag_public, move_down),
        d_hook_method(character, e_flag_public, say),
        d_hook_method(character, e_flag_public, move),
        d_hook_method_override(character, e_flag_public, drawable, draw),
        d_hook_delete(character),
        d_hook_method_tail
};
