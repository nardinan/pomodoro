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
#include "bubble.obj.h"
struct s_bubble_attributes *p_bubble_alloc(struct s_object *self) {
    struct s_bubble_attributes *result = d_prepare(self, bubble);
    f_memory_new(self);                                                                 /* inherit */
    f_mutex_new(self);                                                                  /* inherit */
    f_drawable_new(self, (e_drawable_kind_single|e_drawable_kind_force_visibility));    /* inherit */
    return result;
}

struct s_object *f_bubble_new(struct s_object *self, struct s_object *factory, unsigned int red, unsigned int green, unsigned int blue, unsigned int alpha,
        int font_style) {
    struct s_bubble_attributes *attributes = p_bubble_alloc(self);
    attributes->mask_R = red;
    attributes->mask_G = green;
    attributes->mask_B = blue;
    attributes->mask_A = alpha;
    attributes->font_style = font_style;
    attributes->factory = d_retain(factory);
    return self;
}

d_define_method(bubble, set)(struct s_object *self, struct s_object *drawable, enum e_uiable_components component) {
    d_using(bubble);
    bubble_attributes->drawables[component] = d_retain(drawable);
    return self;
}

d_define_method(bubble, add_message)(struct s_object *self, const char *message, time_t timeout, int font_ID) {
    d_using(bubble);
    struct s_bubble_message *current_message;
    if ((current_message = (struct s_bubble_message *)d_malloc(sizeof(struct s_bubble_message)))) {
        strncpy(current_message->content, message, d_bubble_message_size);
        current_message->font_ID = font_ID;
        current_message->timeout = timeout;
        f_list_append(&(bubble_attributes->messages), (struct s_list_node *)current_message, e_list_insert_tail);
        if (!bubble_attributes->current_element)
            d_call(self, m_bubble_skip, NULL);
    } else
        d_die(d_error_malloc);
    return self;
}

d_define_method(bubble, skip)(struct s_object *self) {
    d_using(bubble);
    TTF_Font *selected_font;
    struct s_factory_attributes *factory_attributes = d_cast(bubble_attributes->factory, factory);
    struct s_label_attributes *label_attributes;
    struct s_bubble_component *current_component;
    char *head_pointer, *next_pointer;
    double maximum_width = 0.0;
    int font_height, index = 0;
    if (bubble_attributes->current_element) {
        while ((current_component = (struct s_bubble_component *)bubble_attributes->components.head)) {
            f_list_delete(&(bubble_attributes->components), (struct s_list_node *)current_component);
            if (current_component->component)
                d_delete(current_component->component);
            d_free(current_component);
        }
        d_free(bubble_attributes->current_element);
        bubble_attributes->current_element = NULL;
    }
    if ((bubble_attributes->current_element = (struct s_bubble_message *)bubble_attributes->messages.head)) {
        f_list_delete(&(bubble_attributes->messages), (struct s_list_node *)bubble_attributes->current_element);
        if ((selected_font = (TTF_Font *)d_call(bubble_attributes->factory, m_factory_get_font, bubble_attributes->current_element->font_ID, 
                        bubble_attributes->font_style, &font_height))) {
            head_pointer = bubble_attributes->current_element->content;
            while (f_string_strlen(head_pointer) > d_bubble_characters_per_line) {
                next_pointer = head_pointer + d_bubble_characters_per_line;
                while ((next_pointer > head_pointer) && (*next_pointer != ' '))
                    --next_pointer;
                if (next_pointer == head_pointer)
                    next_pointer = head_pointer + d_bubble_characters_per_line;
                if ((current_component = (struct s_bubble_component *)d_malloc(sizeof(struct s_bubble_component)))) {
                    strncpy(current_component->content, head_pointer, (next_pointer - head_pointer));
                    if ((current_component->component = f_label_new(d_new(label), current_component->content, selected_font, 
                                    factory_attributes->environment))) {
                        current_component->offset_y = (index * font_height);
                        d_call(current_component->component, m_drawable_set_maskRGB, bubble_attributes->mask_R, bubble_attributes->mask_G,
                                bubble_attributes->mask_B);
                        d_call(current_component->component, m_drawable_set_maskA, bubble_attributes->mask_A);
                    } else
                        d_die(d_error_malloc);
                    f_list_append(&(bubble_attributes->components), (struct s_list_node *)current_component, e_list_insert_tail);
                } else
                    d_die(d_error_malloc);
                head_pointer = (next_pointer + 1);
                ++index;
            }
            if ((current_component = (struct s_bubble_component *)d_malloc(sizeof(struct s_bubble_component)))) {
                strcpy(current_component->content, head_pointer);
                if ((current_component->component = f_label_new(d_new(label), current_component->content, selected_font, factory_attributes->environment))) {
                    current_component->offset_y = (index * font_height);
                    d_call(current_component->component, m_drawable_set_maskRGB, bubble_attributes->mask_R, bubble_attributes->mask_G,
                            bubble_attributes->mask_B);
                    d_call(current_component->component, m_drawable_set_maskA, bubble_attributes->mask_A);
                } else
                    d_die(d_error_malloc);
                f_list_append(&(bubble_attributes->components), (struct s_list_node *)current_component, e_list_insert_tail);
            } else
                d_die(d_error_malloc);
        }
        bubble_attributes->last_update = time(NULL);
    }
    d_foreach(&(bubble_attributes->components), current_component, struct s_bubble_component) {
        label_attributes = d_cast(current_component->component, label);
        current_component->width = label_attributes->last_width;
        current_component->height = label_attributes->last_height;
        if (label_attributes->last_width > maximum_width)
            maximum_width = label_attributes->last_width;
        if (((struct s_list_node *)current_component)->back == NULL) {
            if (bubble_attributes->drawables[e_uiable_component_corner_top_left])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_corner_top_left], e_uiable_mode_active, 
                        e_uiable_component_corner_top_left);
            if (bubble_attributes->drawables[e_uiable_component_top])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_top], e_uiable_mode_active, 
                        e_uiable_component_top);
            if (bubble_attributes->drawables[e_uiable_component_corner_top_right])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_corner_top_right], e_uiable_mode_active, 
                        e_uiable_component_corner_top_right);
        }
        if (((struct s_list_node *)current_component)->next == NULL) {
            if (bubble_attributes->drawables[e_uiable_component_corner_bottom_left])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_corner_bottom_left], e_uiable_mode_active, 
                        e_uiable_component_corner_bottom_left);
            if (bubble_attributes->drawables[e_uiable_component_bottom])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_bottom], e_uiable_mode_active, 
                        e_uiable_component_bottom);
            if (bubble_attributes->drawables[e_uiable_component_corner_bottom_right])
                d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_corner_bottom_right], e_uiable_mode_active, 
                        e_uiable_component_corner_bottom_right);
        }
        if (bubble_attributes->drawables[e_uiable_component_left])
            d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_left], e_uiable_mode_active, 
                    e_uiable_component_left);
        if (bubble_attributes->drawables[e_uiable_component_center])
            d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_center], e_uiable_mode_active, 
                    e_uiable_component_center);
        if (bubble_attributes->drawables[e_uiable_component_right])
            d_call(current_component->component, m_uiable_set, bubble_attributes->drawables[e_uiable_component_right], e_uiable_mode_active, 
                    e_uiable_component_right);
    }
    bubble_attributes->maximum_width = maximum_width;
    d_foreach(&(bubble_attributes->components), current_component, struct s_bubble_component)
        d_call(current_component->component, m_drawable_set_dimension_w, maximum_width);
    return self;
}

d_define_method_override(bubble, draw)(struct s_object *self, struct s_object *environment) {
    d_using(bubble);
    struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
    struct s_drawable_attributes *drawable_attributes_self = d_cast(self, drawable),
                                 *drawable_attributes_selected;
    struct s_bubble_component *current_component;
    double position_x, position_y, new_position_x, new_position_y;
    if (bubble_attributes->current_element)
        if ((bubble_attributes->current_element->timeout + bubble_attributes->last_update) < time(NULL))
            d_call(self, m_bubble_skip, NULL);
    if (bubble_attributes->current_element) {
        d_call(self, m_drawable_get_position, &position_x, &position_y);
        d_foreach(&(bubble_attributes->components), current_component, struct s_bubble_component)
            if (current_component->component) {
                drawable_attributes_selected = d_cast(current_component->component, drawable);
                new_position_x = position_x + current_component->offset_x;
                new_position_y = position_y + current_component->offset_y;
                d_call(current_component->component, m_drawable_set_position, new_position_x, new_position_y);
                drawable_attributes_selected->angle = drawable_attributes_self->angle;
                drawable_attributes_selected->flip = drawable_attributes_self->flip;
                if ((d_call(current_component->component, m_drawable_normalize_scale, 
                                environment_attributes->reference_w[environment_attributes->current_surface],
                                environment_attributes->reference_h[environment_attributes->current_surface],
                                environment_attributes->camera_origin_x[environment_attributes->current_surface],
                                environment_attributes->camera_origin_y[environment_attributes->current_surface],
                                environment_attributes->camera_focus_x[environment_attributes->current_surface],
                                environment_attributes->camera_focus_y[environment_attributes->current_surface],
                                environment_attributes->current_w,
                                environment_attributes->current_h,
                                environment_attributes->zoom[environment_attributes->current_surface])))
                    while(((int)d_call(current_component->component, m_drawable_draw, environment)) == d_drawable_return_continue);
            }
    }
    d_cast_return(d_drawable_return_last);
}

d_define_method(bubble, delete)(struct s_object *self, struct s_bubble_attributes *attributes) {
    struct s_factory_attributes *factory_attributes = d_cast(attributes->factory, factory);
    struct s_bubble_component *current_component;
    struct s_bubble_message *current_message;
    int index;
    d_delete(attributes->factory);
    if (attributes->current_element) {
        while ((current_component = (struct s_bubble_component *)attributes->components.head)) {
            f_list_delete(&(attributes->components), (struct s_list_node *)current_component);
            if (current_component->component) {
                d_call(factory_attributes->environment, m_environment_del_drawable, current_component->component, d_bubble_layer_default, 
                        e_environment_surface_primary);
                d_delete(current_component->component);
            }
            d_free(current_component);
        }
        d_free(attributes->current_element);
        attributes->current_element = NULL;
    }
    while ((current_message = (struct s_bubble_message *)attributes->messages.head)) {
        f_list_delete(&(attributes->messages), (struct s_list_node *)current_message);
        d_free(current_message);
    }
    for (index = 0; index < e_uiable_component_NULL; ++index)
        if (attributes->drawables[index])
            d_delete(attributes->drawables[index]);
    return NULL;
}

d_define_class(bubble) {
    d_hook_method(bubble, e_flag_public, set),
        d_hook_method(bubble, e_flag_public, add_message),
        d_hook_method(bubble, e_flag_public, skip),
        d_hook_method_override(bubble, e_flag_public, drawable, draw),
        d_hook_delete(bubble),
        d_hook_method_tail
};
