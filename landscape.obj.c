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
#include "landscape.obj.h"
struct s_landscape_attributes *p_landscape_alloc(struct s_object *self) {
    struct s_landscape_attributes *result = d_prepare(self, landscape);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_landscape_new(struct s_object *self, const char *key) {
    struct s_landscape_attributes *attributes = p_landscape_alloc(self);
    strncpy(attributes->label, key, d_entity_label_size);
    return self;
}

d_define_method(landscape, load)(struct s_object *self, struct s_object *json, struct s_object *factory) {
    d_using(landscape);
    enum e_drawable_flips flips;
    enum e_factory_media_types type;
    char *string_supply, *string_supply_item, *string_supply_track, *string_supply_label;
    t_boolean status_flip_x = d_false, status_flip_y = d_false, layer_flip_x, layer_flip_y, solid, active;
    double mask_R, mask_G, mask_B, mask_A, status_zoom = 1.0, layer_zoom, item_zoom, position_x, position_y, layer, volume, loops;
    int index_layer = 0, index_path = 0, index_item = 0, index_track = 0;
    struct s_object *item_json;
    struct s_landscape_point *current_point;
    struct s_landscape_item *current_item;
    struct s_landscape_track *current_track;
    struct s_landscape_surface *current_surface;
    if (d_call(json, m_json_get_string, &string_supply, "s", "format"))
        if (f_string_strcmp(string_supply, "landscape") == 0)
            if ((d_call(json, m_json_get_string, &string_supply, "s", "ID"))) {
                d_call(json, m_json_get_boolean, &status_flip_x, "s", "flip_x");
                d_call(json, m_json_get_boolean, &status_flip_y, "s", "flip_y");
                d_call(json, m_json_get_double, &status_zoom, "s", "zoom");
                d_call(json, m_json_get_double, &(landscape_attributes->position_x), "s", "position_x");
                d_call(json, m_json_get_double, &(landscape_attributes->position_y), "s", "position_y");
                if ((d_call(json, m_json_get_string, &string_supply, "s", "intro_script")))
                    strncpy(landscape_attributes->intro_script, string_supply, d_string_buffer_size);
                if ((d_call(json, m_json_get_string, &string_supply, "s", "outro_script")))
                    strncpy(landscape_attributes->outro_script, string_supply, d_string_buffer_size);
                while ((d_call(json, m_json_get_double, &position_x, "sds", "floor", index_path, "position_x")) && 
                        (d_call(json, m_json_get_double, &position_y, "sds", "floor", index_path, "position_y"))) {
                    if ((current_point = (struct s_landscape_point *)d_malloc(sizeof(struct s_landscape_point)))) {
                        current_point->position_x = position_x;
                        current_point->position_y = position_y;
                        current_point->scale_min = 1.0;
                        current_point->scale_max = 1.0;
                        d_call(json, m_json_get_double, &(current_point->dimension_h), "sds", "floor", index_path, "dimension_h");
                        d_call(json, m_json_get_double, &(current_point->scale_min), "sds", "floor", index_path, "scale_min");
                        d_call(json, m_json_get_double, &(current_point->scale_max), "sds", "floor", index_path, "scale_max");
                        f_list_append(&(landscape_attributes->points), (struct s_list_node *)current_point, e_list_insert_tail);
                    } else
                        d_die(d_error_malloc);
                    ++index_path;
                }
                while (((d_call(json, m_json_get_string, &string_supply_item, "sds", "items", index_item, "item"))) && 
                        (d_call(json, m_json_get_string, &string_supply_label, "sds", "items", index_item, "label"))) {
                    item_zoom = 1.0;
                    layer = d_landscape_item_default_layer;
                    d_call(json, m_json_get_double, &item_zoom, "sds", "items", index_item, "zoom");
                    if ((item_json = d_call(factory, m_factory_get_json, string_supply_item))) {
                        if ((current_item = (struct s_landscape_item *)d_malloc(sizeof(struct s_landscape_item)))) {
                            strncpy(current_item->label, string_supply_label, d_entity_label_size);
                            d_call(json, m_json_get_double, &(current_item->position_x), "sds", "items", index_item, "position_x");
                            d_call(json, m_json_get_double, &(current_item->position_y), "sds", "items", index_item, "position_y");
                            d_call(json, m_json_get_double, &layer, "sds", "items", index_item, "layer");
                            current_item->layer = (int)layer;
                            if ((current_item->item = f_item_new(d_new(item), string_supply_item))) {
                                d_call(current_item->item, m_item_load, item_json, factory);
                                d_call(current_item->item, m_drawable_set_center, (0.0 - current_item->position_x), (0.0 - current_item->position_y)); /* reset the zoom-on-ROI */
                                d_call(current_item->item, m_drawable_set_zoom, (item_zoom * status_zoom));
                                if ((d_call(json, m_json_get_string, &string_supply, "sds", "items", index_item, "script")))
                                    strncpy(current_item->script, string_supply, d_resources_key_size);
                                if ((d_call(json, m_json_get_string, &string_supply, "sds", "items", index_item, "status")))
                                    d_call(current_item->item, m_entity_set_component, string_supply);
                                if ((d_call(json, m_json_get_boolean, &solid, "sds", "items", index_item, "solid")))
                                    d_call(current_item->item, m_item_set_solid, solid);
                                if ((d_call(json, m_json_get_boolean, &active, "sds", "items", index_item, "active")))
                                    d_call(current_item->item, m_item_set_active, active);
                                f_list_append(&(landscape_attributes->items), (struct s_list_node *)current_item, e_list_insert_head);
                            }
                        } else
                            d_die(d_error_malloc);
                        d_delete(item_json);
                    }
                    ++index_item;
                }
                while (((d_call(json, m_json_get_string, &string_supply_track, "sds", "tracks", index_track, "playable"))) &&
                        (d_call(json, m_json_get_string, &string_supply_label, "sds", "tracks", index_track, "label"))) {
                    if ((current_track = (struct s_landscape_track *)d_malloc(sizeof(struct s_landscape_track)))) {
                        strncpy(current_track->label, string_supply_label, d_entity_label_size);
                        volume = d_track_default_volume;
                        loops = d_track_infinite_loop;
                        d_call(json, m_json_get_double, &volume, "sds", "tracks", index_track, "volume");
                        d_call(json, m_json_get_double, &loops, "sds", "tracks", index_track, "loops");
                        if ((current_track->track = d_call(factory, m_factory_get_track, string_supply_track))) {
                            d_call(current_track->track, m_track_set_loops, (int)loops);
                            d_call(current_track->track, m_track_set_volume, (int)volume);
                            f_list_append(&(landscape_attributes->tracks), (struct s_list_node *)current_track, e_list_insert_head);
                        }
                    } else
                        d_die(d_error_malloc);
                    ++index_track;
                }
                while ((d_call(json, m_json_get_string, &string_supply, "sds", "surfaces", index_layer, "drawable"))) {
                    layer_flip_x = status_flip_x;
                    layer_flip_y = status_flip_y;
                    mask_R = 255.0;
                    mask_G = 255.0;
                    mask_B = 255.0;
                    mask_A = 255.0;
                    layer_zoom = 1.0;
                    layer = d_landscape_surface_default_layer;
                    d_call(json, m_json_get_double, &mask_R, "sds", "surfaces", index_layer, "mask_R");
                    d_call(json, m_json_get_double, &mask_G, "sds", "surfaces", index_layer, "mask_G");
                    d_call(json, m_json_get_double, &mask_B, "sds", "surfaces", index_layer, "mask_B");
                    d_call(json, m_json_get_double, &mask_A, "sds", "surfaces", index_layer, "mask_A");
                    d_call(json, m_json_get_boolean, &layer_flip_x, "sds", "surfaces", index_layer, "flip_x");
                    d_call(json, m_json_get_boolean, &layer_flip_y, "sds", "surfaces", index_layer, "flip_y");
                    d_call(json, m_json_get_double, &layer_zoom, "sds", "surfaces", index_layer, "zoom");
                    if ((current_surface = (struct s_landscape_surface *)d_malloc(sizeof(struct s_landscape_surface)))) {
                        current_surface->speed_ratio_x = 1.0;
                        current_surface->speed_ratio_y = 1.0;
                        d_call(json, m_json_get_double, &(current_surface->offset_x), "sds", "surfaces", index_layer, "offset_x");
                        d_call(json, m_json_get_double, &(current_surface->offset_y), "sds", "surfaces", index_layer, "offset_y");
                        d_call(json, m_json_get_double, &(current_surface->speed_ratio_x), "sds", "surfaces", index_layer, "speed_ratio_x");
                        d_call(json, m_json_get_double, &(current_surface->speed_ratio_y), "sds", "surfaces", index_layer, "speed_ratio_y");
                        d_call(json, m_json_get_double, &layer, "sds", "surfaces", index_layer, "layer");
                        current_surface->layer = (int)layer;
                        if ((current_surface->drawable = d_call(factory, m_factory_get_media, string_supply, &type))) {
                            if ((layer_flip_x) && (layer_flip_y))
                                flips = e_drawable_flip_both;
                            else if (layer_flip_x)
                                flips = e_drawable_flip_horizontal;
                            else if (layer_flip_y)
                                flips = e_drawable_flip_vertical;
                            else
                                flips = e_drawable_flip_none;
                            d_call(current_surface->drawable, m_drawable_flip, flips);
                            d_call(current_surface->drawable, m_drawable_set_center, (0.0 - current_surface->offset_x), (0.0 - current_surface->offset_y)); /* reset the zoom-on-ROI */
                            d_call(current_surface->drawable, m_drawable_set_zoom, (layer_zoom * status_zoom));
                            d_call(current_surface->drawable, m_drawable_set_maskRGB, (unsigned int)mask_R, (unsigned int)mask_G, (unsigned int)mask_B);
                            d_call(current_surface->drawable, m_drawable_set_maskA, (unsigned int)mask_A);
                            f_list_append(&(landscape_attributes->surfaces), (struct s_list_node *)current_surface, e_list_insert_head);
                        } else
                            d_free(current_surface);
                    } else
                        d_die(d_error_malloc);
                    ++index_layer;
                }

            }
    return self;
}

d_define_method(landscape, show)(struct s_object *self, struct s_object *environment) {
    d_using(landscape);
    struct s_landscape_surface *current_surface;
    struct s_landscape_item *current_item;
    d_foreach(&(landscape_attributes->surfaces), current_surface, struct s_landscape_surface) {
        d_call(current_surface->drawable, m_drawable_set_position, (landscape_attributes->position_x + current_surface->offset_x), 
                (landscape_attributes->position_y + current_surface->offset_y));
        d_call(environment, m_environment_add_drawable, current_surface->drawable, current_surface->layer, e_environment_surface_primary);
    }
    d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item) {
        d_call(current_item->item, m_item_play, NULL);
        d_call(current_item->item, m_drawable_set_position, (landscape_attributes->position_x + current_item->position_x),
                (landscape_attributes->position_y + current_item->position_y));
        d_call(environment, m_environment_add_drawable, current_item->item, current_item->layer, e_environment_surface_primary);
    }
    return self;
}

d_define_method(landscape, hide)(struct s_object *self, struct s_object *environment) {
    d_using(landscape);
    struct s_landscape_surface *current_surface;
    struct s_landscape_item *current_item;
    d_call(self, m_landscape_stop, NULL);
    d_foreach(&(landscape_attributes->surfaces), current_surface, struct s_landscape_surface)
        d_call(environment, m_environment_del_drawable, current_surface->drawable, current_surface->layer, e_environment_surface_primary);
    d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item) {
        d_call(current_item->item, m_item_mute, NULL);
        d_call(environment, m_environment_del_drawable, current_item->item, current_item->layer, e_environment_surface_primary);
    }
    return self;
}

d_define_method(landscape, stop)(struct s_object *self) {
    d_using(landscape);
    struct s_landscape_track *current_track;
    d_foreach(&(landscape_attributes->tracks), current_track, struct s_landscape_track)
        if (current_track->track)
            d_call(current_track->track, m_track_stop, NULL);
    return self;
}

d_define_method(landscape, play)(struct s_object *self, const char *label) {
    d_using(landscape);
    struct s_landscape_track *current_track;
    d_call(self, m_landscape_stop, NULL);
    d_foreach(&(landscape_attributes->tracks), current_track, struct s_landscape_track)
        if (f_string_strcmp(current_track->label, label) == 0) {
            if (current_track->track)
               d_call(current_track->track, m_track_play, d_true);
            break;
        }
    return self;
}

d_define_method(landscape, set_item_solid)(struct s_object *self, const char *label, t_boolean solid) {
    d_using(landscape);
    struct s_landscape_item *current_item;
    d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item)
        if (f_string_strcmp(current_item->label, label) == 0)
            d_call(current_item->item, m_item_set_solid, solid);
    return self;
}

d_define_method(landscape, set_item_active)(struct s_object *self, const char *label, t_boolean active) {
    d_using(landscape);
    struct s_landscape_item *current_item;
    d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item)
        if (f_string_strcmp(current_item->label, label) == 0)
            d_call(current_item->item, m_item_set_active, active);
    return self;
}

d_define_method(landscape, set_item_status)(struct s_object *self, const char *label, const char *status) {
    d_using(landscape);
    struct s_landscape_item *current_item;
    d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item)
        if (f_string_strcmp(current_item->label, label) == 0)
            d_call(current_item->item, m_entity_set_component, status);
    return self;
}

d_define_method(landscape, floor)(struct s_object *self, double position_x, double *position_y, double *dimension_h, double *scale_min, double *scale_max) {
    d_using(landscape);
    struct s_landscape_point *current_point = NULL, *previous_point = NULL;
    double ratio;
    position_x -= landscape_attributes->position_x;
    d_foreach(&(landscape_attributes->points), current_point, struct s_landscape_point) {
        if (current_point->position_x >= position_x)
            break;
        previous_point = current_point;
    }  
    if ((previous_point) && (current_point)) {
        ratio = (position_x - previous_point->position_x)/(current_point->position_x - previous_point->position_x);
        *position_y = previous_point->position_y + (ratio * (current_point->position_y - previous_point->position_y));
        *dimension_h = previous_point->dimension_h + (ratio * (current_point->dimension_h - previous_point->dimension_h));
        *scale_min = previous_point->scale_min + (ratio * (current_point->scale_min - previous_point->scale_min));
        *scale_max = previous_point->scale_max + (ratio * (current_point->scale_max - previous_point->scale_max));
    } else if (previous_point) {
        *position_y = previous_point->position_y;
        *dimension_h = previous_point->dimension_h;
        *scale_min = previous_point->scale_min;
        *scale_max = previous_point->scale_max;
    }
    *position_y += landscape_attributes->position_y;
    return self;
}

d_define_method(landscape, validator)(struct s_object *self, struct s_object *entity, double current_x, double current_y, double *new_x, double *new_y,
        double *new_z, double camera_offset_x, double camera_offset_y) {
    d_using(landscape);
    struct s_landscape_item *current_item, *selected_item = NULL;
    struct s_item_attributes *item_attributes;
    double entity_position_x, entity_position_y, item_position_x, item_position_y, final_distance, valid_y, valid_h, scale_min, scale_max, ratio = 0.0;
    if (entity) {
        d_call(entity, m_drawable_get_scaled_principal_point, &entity_position_x, &entity_position_y);
        d_foreach(&(landscape_attributes->items), current_item, struct s_landscape_item) { 
            d_call(current_item->item, m_drawable_get_scaled_principal_point, &item_position_x, &item_position_y);
            if ((final_distance = d_point_square_distance(entity_position_x, entity_position_y, item_position_x, item_position_y)) < 
                    d_item_max_square_distance)
                if ((intptr_t)d_call(current_item->item, m_item_collision, entity)) {
                    item_attributes = d_cast(current_item->item, item);
                    if (item_attributes->active) /* return the latest active item that has been selected */
                        selected_item = current_item;
                    item_position_x += camera_offset_x;
                    item_position_y += camera_offset_y;
                    if ((d_point_square_distance(current_x, current_y, item_position_x, item_position_y) >=
                                d_point_square_distance(*new_x, *new_y, item_position_x, item_position_y)))
                        if (item_attributes->solid)
                            *new_x = current_x;
                }
        }
        d_call(self, m_landscape_floor, *new_x, &valid_y, &valid_h, &scale_min, &scale_max);
        if (*new_y < (valid_y - valid_h))
            *new_y = (valid_y - valid_h);
        else if (*new_y > valid_y)
            *new_y = valid_y;
        if (valid_h > 0)
            ratio = (*new_y - (valid_y - valid_h))/valid_h;
        *new_z = scale_min + (ratio * (scale_max - scale_min));
    }
    d_cast_return(selected_item);
}

d_define_method(landscape, update)(struct s_object *self, struct s_object *environment) {
    d_using(landscape);
    double camera_position_x, camera_position_y, position_x, position_y;
    struct s_landscape_surface *current_surface;
    d_call(environment, m_environment_get_camera, &camera_position_x, &camera_position_y, e_environment_surface_primary);
    d_foreach(&(landscape_attributes->surfaces), current_surface, struct s_landscape_surface) {
        position_x = (landscape_attributes->position_x + current_surface->offset_x) + 
            (camera_position_x * (1.0 - current_surface->speed_ratio_x));
        position_y = (landscape_attributes->position_y + current_surface->offset_y) +
            (camera_position_y * (1.0 - current_surface->speed_ratio_y));
        d_call(current_surface->drawable, m_drawable_set_position, position_x, position_y);
    }
    return self;
}

d_define_method(landscape, delete)(struct s_object *self, struct s_landscape_attributes *attributes) {
    struct s_landscape_surface *current_surface;
    struct s_landscape_item *current_item;
    struct s_landscape_track *current_track;
    struct s_landscape_point *current_point;
    double position_x, position_y, zoom;
    while ((current_surface = (struct s_landscape_surface *)attributes->surfaces.head)) {
        f_list_delete(&(attributes->surfaces), (struct s_list_node *)current_surface);
        d_delete(current_surface->drawable);
        d_free(current_surface);
    }
    while ((current_item = (struct s_landscape_item *)attributes->items.head)) {
        f_list_delete(&(attributes->items), (struct s_list_node *)current_item);
        if (v_developer_mode) {
            /* dump of the item */
            d_call(current_item->item, m_drawable_get_position, &position_x, &position_y);
            d_call(current_item->item, m_drawable_get_zoom, &zoom);
            printf("{\"item\":\"%s\", \"position_x\":%.01f, \"position_y\":%.01f, \"zoom\":%.02f}\n", current_item->label, 
                    (position_x - attributes->position_x), (position_y - attributes->position_y), zoom);
        }
        d_delete(current_item->item);
        d_free(current_item);
    }
    while ((current_track = (struct s_landscape_track *)attributes->tracks.head)) {
        f_list_delete(&(attributes->tracks), (struct s_list_node *)current_track);
        if (current_track->track)
            d_delete(current_track->track);
        d_free(current_track);
    }
    while ((current_point = (struct s_landscape_point *)attributes->points.head)) {
        f_list_delete(&(attributes->points), (struct s_list_node *)current_point);
        d_free(current_point);
    }
    return NULL;
}

d_define_class(landscape) {
    d_hook_method(landscape, e_flag_public, load),
        d_hook_method(landscape, e_flag_public, show),
        d_hook_method(landscape, e_flag_public, hide),
        d_hook_method(landscape, e_flag_public, stop),
        d_hook_method(landscape, e_flag_public, play),
        d_hook_method(landscape, e_flag_public, set_item_solid),
        d_hook_method(landscape, e_flag_public, set_item_active),
        d_hook_method(landscape, e_flag_public, set_item_status),
        d_hook_method(landscape, e_flag_public, floor),
        d_hook_method(landscape, e_flag_public, validator),
        d_hook_method(landscape, e_flag_public, update),
        d_hook_delete(landscape),
        d_hook_method_tail
};
