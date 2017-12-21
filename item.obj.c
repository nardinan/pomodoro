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
#include "item.obj.h"
struct s_item_attributes *p_item_alloc(struct s_object *self, const char *key) {
    struct s_item_attributes *result = d_prepare(self, item);
    f_memory_new(self);             /* inherit */
    f_mutex_new(self);              /* inherit */
    f_entity_new(self, key, NULL);  /* inherit */
    f_controllable_new(self);       /* inherit */
    return result;
}

struct s_object *f_item_new(struct s_object *self, const char *key) {
    struct s_item_attributes *attributes = p_item_alloc(self, key);
    d_call(self, m_controllable_add_configuration, SDLK_LSHIFT, p_item_blink,  p_item_blink,  p_item_blink,  d_true);
    d_call(self, m_controllable_add_configuration, SDLK_RSHIFT, p_item_blink,  p_item_blink,  p_item_blink,  d_true);
    d_call(self, m_controllable_set, d_true);
    attributes->active = d_false;
    attributes->blink = d_false;
    attributes->green_channel = d_item_blink_max_channel;
    attributes->green_modificator = d_item_blink_modificator;
    if (v_developer_mode) {
        d_call(self, m_morphable_set_visibility, d_true);
        d_call(self, m_morphable_set_freedom_x, d_true);
        d_call(self, m_morphable_set_freedom_y, d_true);
        d_call(self, m_morphable_set_freedom_z, d_true);
    }
    return self;
}

d_define_method(item, load)(struct s_object *self, struct s_object *json, struct s_object *factory) {
    d_using(item);
    struct s_object *drawable;
    struct s_item_track *current_track;
    enum e_drawable_flips flips;
    enum e_factory_media_types type;
    char *string_supply, *string_supply_component;
    t_boolean status_flip_x = d_false, status_flip_y = d_false, item_flip_x, item_flip_y;
    double offset_x, offset_y, mask_R = 255.0, mask_G = 255.0, mask_B = 255.0, mask_A = 255.0, zoom = 1.0, volume, loops;
    int index_status = 0, index_layer;
    if (d_call(json, m_json_get_string, &string_supply, "s", "format"))
        if (f_string_strcmp(string_supply, "item") == 0)
            if ((d_call(json, m_json_get_string, &string_supply, "s", "ID"))) {
                d_call(json, m_json_get_boolean, &status_flip_x, "s", "flip_x");
                d_call(json, m_json_get_boolean, &status_flip_y, "s", "flip_y");
                d_call(json, m_json_get_double, &zoom, "s", "zoom");
                d_call(json, m_json_get_double, &(item_attributes->width), "s", "width");
                d_call(json, m_json_get_double, &(item_attributes->height), "s", "height");
                d_call(json, m_json_get_boolean, &(item_attributes->active), "s", "active");
                d_call(json, m_json_get_boolean, &(item_attributes->solid), "s", "solid");
                item_attributes->width *= zoom;
                item_attributes->height *= zoom;
                while (d_call(json, m_json_get_string, &string_supply_component, "sds", "statuses", index_status, "label")) {
                    d_call(self, m_entity_add_component, string_supply_component, 0.0, 0.0, 0.0, 0.0, 0.0); /* the component is not moving */
                    if ((d_call(json, m_json_get_string, &string_supply, "sdss", "statuses", index_status, "track", "playable"))) {
                        if ((current_track = (struct s_item_track *)d_malloc(sizeof(struct s_item_track)))) {
                            strncpy(current_track->label, string_supply_component, d_entity_label_size);
                            volume = d_track_default_volume;
                            loops = d_track_infinite_loop;
                            d_call(json, m_json_get_double, &volume, "sdss", "statuses", index_status, "track", "volume");
                            d_call(json, m_json_get_double, &loops, "sdss", "statuses", index_status, "track", "loops");
                            current_track->volume = (int)volume;
                            if ((current_track->track = d_call(factory, m_factory_get_track, string_supply))) {
                                d_call(current_track->track, m_track_set_loops, (int)loops);
                                d_call(current_track->track, m_track_set_volume, (int)(volume * d_pomodoro_general_volume));
                                f_list_append(&(item_attributes->tracks), (struct s_list_node *)current_track, e_list_insert_head);
                            } else
                                d_free(current_track);
                        } else
                            d_die(d_error_malloc);
                    }
                    index_layer = 0;
                    while ((d_call(json, m_json_get_string, &string_supply, "sdsds", "statuses", index_status, "layers", index_layer, "drawable"))) {
                        offset_x = 0;
                        offset_y = 0;
                        item_flip_x = status_flip_x;
                        item_flip_y = status_flip_y;
                        mask_R = 255.0;
                        mask_G = 255.0;
                        mask_B = 255.0;
                        mask_A = 255.0;
                        d_call(json, m_json_get_double, &offset_x, "sdsds", "statuses", index_status, "layers", index_layer, "offset_x");
                        d_call(json, m_json_get_double, &offset_y, "sdsds", "statuses", index_status, "layers", index_layer, "offset_y");
                        d_call(json, m_json_get_boolean, &item_flip_x, "sdsds", "statuses", index_status, "layers", index_layer, "flip_x");
                        d_call(json, m_json_get_boolean, &item_flip_y, "sdsds", "statuses", index_status, "layers", index_layer, "flip_y");
                        d_call(json, m_json_get_double, &mask_R, "sdsds", "statuses", index_status, "layers", index_layer, "mask_R");
                        d_call(json, m_json_get_double, &mask_G, "sdsds", "statuses", index_status, "layers", index_layer, "mask_G");
                        d_call(json, m_json_get_double, &mask_B, "sdsds", "statuses", index_status, "layers", index_layer, "mask_B");
                        d_call(json, m_json_get_double, &mask_A, "sdsds", "statuses", index_status, "layers", index_layer, "mask_A");
                        if ((drawable = d_call(factory, m_factory_get_media, string_supply, &type))) {
                            if ((item_flip_x) && (item_flip_y))
                                flips = e_drawable_flip_both;
                            else if (item_flip_x)
                                flips = e_drawable_flip_horizontal;
                            else if (item_flip_y)
                                flips = e_drawable_flip_vertical;
                            else
                                flips = e_drawable_flip_none;
                            d_call(drawable, m_drawable_flip, flips);
                            d_call(self, m_entity_add_element, string_supply_component, offset_x, offset_y, drawable);
                            d_call(drawable, m_drawable_set_maskRGB, (unsigned int)mask_R, (unsigned int)mask_G, (unsigned int)mask_B);
                            d_call(drawable, m_drawable_set_maskA, (unsigned int)mask_A);
                            d_delete(drawable);
                        }
                        ++index_layer;
                    }
                    ++index_status;
                }
                d_call(self, m_drawable_set_zoom, zoom);
            }
    return self;
}

d_define_method(item, mute)(struct s_object *self) {
    d_using(item);
    item_attributes->audio = d_false;
    if (item_attributes->current_track)
        d_call(item_attributes->current_track->track, m_track_stop, NULL);
    return self;
}

d_define_method(item, play)(struct s_object *self) {
    d_using(item);
    item_attributes->audio = d_true;
    if (item_attributes->current_track) {
        d_call(item_attributes->current_track->track, m_track_set_volume, (int)(d_track_default_volume * d_pomodoro_general_volume));
        d_call(item_attributes->current_track->track, m_track_play, d_true); 
    }
    return self;
}

d_define_method_override(item, set_component)(struct s_object *self, char *label) {
    d_using(item);
    struct s_entity_attributes *entity_attributes = d_cast(self, entity);
    struct s_animation_attributes *animation_attributes;
    struct s_entity_element *current_element;
    struct s_item_track *current_track;
    struct s_object *result = self;
    if (item_attributes->current_track) {
        d_call(item_attributes->current_track->track, m_track_stop, NULL);
        item_attributes->current_track = NULL;
    }
    result = d_call_owner(self, entity, m_entity_set_component, label);
    if (entity_attributes->current_component) {
        d_foreach(&(entity_attributes->current_component->elements), current_element, struct s_entity_element)
            if ((animation_attributes = d_cast(current_element->drawable, animation))) {
                d_call(current_element->drawable, m_animation_set_status, e_animation_direction_stop);
                d_call(current_element->drawable, m_animation_set_status, e_animation_direction_forward);
            }
    }
    d_foreach(&(item_attributes->tracks), current_track, struct s_item_track)
        if (f_string_strcmp(current_track->label, label) == 0) {
            item_attributes->current_track = current_track;
            if (item_attributes->audio) {
                d_call(item_attributes->current_track->track, m_track_set_volume, (int)(d_track_default_volume * d_pomodoro_general_volume));
                d_call(item_attributes->current_track->track, m_track_play, d_true);
            }
            break;
        }
    return result;
}

d_define_method(item, set_solid)(struct s_object *self, t_boolean solid) {
    d_using(item);
    item_attributes->solid = solid;
    return self;
}

d_define_method(item, set_active)(struct s_object *self, t_boolean active) {
    d_using(item);
    item_attributes->active = active;
    return self;
}

d_define_method(item, blink)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
    d_using(item);
    if (item_attributes->active) {
        if (pressed)
            item_attributes->blink = d_true;
        else {
            item_attributes->blink = d_false;
            item_attributes->green_channel = d_item_blink_max_channel;
            item_attributes->green_modificator = -d_item_blink_modificator;
            d_call(self, m_drawable_set_maskRGB, (unsigned int)d_item_blink_max_channel, (unsigned int)d_item_blink_max_channel, 
                    (unsigned int)d_item_blink_max_channel);
        }
    }
    return self;
}

d_define_method(item, collision)(struct s_object *self, struct s_object *entity) {
    t_boolean result = d_false;
    double entity_principal_point_x, entity_principal_point_y, item_position_x, item_position_y, item_width, item_height;
    d_call(entity, m_drawable_get_scaled_principal_point, &entity_principal_point_x, &entity_principal_point_y);
    d_call(self, m_drawable_get_scaled_position, &item_position_x, &item_position_y);
    d_call(self, m_drawable_get_scaled_dimension, &item_width, &item_height);
    if ((entity_principal_point_x > item_position_x) && (entity_principal_point_x < (item_position_x + item_width)))
        result = d_true;
    d_cast_return(result);
}

d_define_method_override(item, draw)(struct s_object *self, struct s_object *environment) {
    d_using(item);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    double distance, volume = 0, position_x, position_y, dimension_w, dimension_h, item_center_x, item_center_y, screen_center_x, screen_center_y;
    d_call(self, m_morphable_update, environment);
    if (item_attributes->blink) {
        item_attributes->green_channel += item_attributes->green_modificator;
        if (item_attributes->green_channel >= d_item_blink_max_channel) {
            item_attributes->green_channel = d_item_blink_max_channel;
            item_attributes->green_modificator = -d_item_blink_modificator;
        } else if (item_attributes->green_channel < d_item_blink_min_channel) {
            item_attributes->green_channel = d_item_blink_min_channel;
            item_attributes->green_modificator = d_item_blink_modificator;
        }
        d_call(self, m_drawable_set_maskRGB, (unsigned int)item_attributes->green_channel, (unsigned int)d_item_blink_max_channel, 
                (unsigned int)item_attributes->green_channel);
    }
    if ((item_attributes->current_track) && (item_attributes->audio)) {
        d_call(self, m_drawable_get_scaled_position, &position_x, &position_y);
        d_call(self, m_drawable_get_scaled_dimension, &dimension_w, &dimension_h);
        item_center_x = (position_x + (dimension_w / 2.0));
        item_center_y = (position_y + (dimension_h / 2.0));
        screen_center_x = (environment_attributes->current_w / 2.0);
        screen_center_y = (environment_attributes->current_h / 2.0);
        if ((distance = d_point_square_distance(item_center_x, item_center_y, screen_center_x, screen_center_y)) > d_item_max_square_distance) {
            if (distance < d_item_lost_square_distance)
                volume = item_attributes->current_track->volume * 
                    (1.0 - ((distance - d_item_max_square_distance)/(d_item_lost_square_distance - d_item_max_square_distance)));
            else
                volume = 0;
        } else
            volume = item_attributes->current_track->volume;
        d_call(item_attributes->current_track->track, m_track_set_volume, (int)(volume * d_pomodoro_general_volume));
    }
    return d_call_owner(self, entity, m_drawable_draw, environment); /* recall the father's draw method */
}

d_define_method(item, delete)(struct s_object *self, struct s_item_attributes *attributes) {
    struct s_item_track *current_track;
    if (attributes->current_track)
        d_call(attributes->current_track->track, m_track_stop, NULL);
    while ((current_track = (struct s_item_track *)attributes->tracks.head)) {
        f_list_delete(&(attributes->tracks), (struct s_list_node *)current_track);
        d_delete(current_track->track);
        d_free(current_track);
    }
    return NULL;
}

d_define_class(item) {
    d_hook_method(item, e_flag_public, load),
        d_hook_method(item, e_flag_public, mute),
        d_hook_method(item, e_flag_public, play),
        d_hook_method_override(item, e_flag_public, entity, set_component),
        d_hook_method(item, e_flag_public, set_solid),
        d_hook_method(item, e_flag_public, set_active),
        d_hook_method(item, e_flag_public, blink),
        d_hook_method(item, e_flag_public, collision),
        d_hook_method_override(item, e_flag_public, drawable, draw),
        d_hook_delete(item),
        d_hook_method_tail
};
