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
#include "effecteer.obj.h"
#include "director.obj.h"
void p_link_effecteer(enum e_effecteer_actions type, ...) {
    va_list parameters_list;
    struct s_director_action *action;
    struct s_lisp_object *argument;
    va_start(parameters_list, type);
    if ((action = d_call(director, m_director_new_action, e_director_action_effecteer))) {
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
            strncpy(action->action.effect.key, argument->value_string, d_entity_label_size);
            switch ((action->action.effect.type = type)) {
                case e_effecteer_action_add:
                    action->action.effect.parameters.action_add.zoom = 1.0;
                    if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                        strncpy(action->action.effect.parameters.action_add.label, argument->value_string, d_string_buffer_size);
                        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                            action->action.effect.parameters.action_add.position_x = argument->value_double;
                            if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                action->action.effect.parameters.action_add.position_y = argument->value_double;
                                if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                    action->action.effect.parameters.action_add.zoom = argument->value_double;
                                    if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                        action->action.effect.parameters.action_add.angle = argument->value_double;
                                        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                            action->action.effect.parameters.action_add.absolute = d_lisp_true_token(argument);
                                            if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
                                                action->action.effect.parameters.action_add.front = d_lisp_true_token(argument);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    break;
                case e_effecteer_action_play:
                    action->action.effect.parameters.action_play.volume = d_track_default_volume;
                    action->action.effect.parameters.action_play.fade_in = d_track_default_fade_delay;
                    action->action.effect.parameters.action_play.fade_out = d_track_default_fade_delay;
                    action->action.effect.parameters.action_play.loop = d_true;
                    if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                        strncpy(action->action.effect.parameters.action_play.label, argument->value_string, d_string_buffer_size);
                        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                            action->action.effect.parameters.action_play.fade_in = argument->value_double;
                            if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                action->action.effect.parameters.action_play.fade_out = argument->value_double;
                                if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                    action->action.effect.parameters.action_play.volume = argument->value_double;
                                    if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
                                        action->action.effect.parameters.action_play.loop = d_lisp_true_token(argument);
                                }
                            }
                        }
                    }
                    break;
                case e_effecteer_action_write:
                    if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                        strncpy(action->action.effect.parameters.action_write.label, argument->value_string, d_string_buffer_size);
                        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                            action->action.effect.parameters.action_write.layer = (int)argument->value_double;
                            if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                if (argument->type == e_lisp_object_type_symbol) {
                                    /* means that we should aim for the center of the screen */
                                    action->action.effect.parameters.action_write.position_x = NAN;
                                } else {
                                    action->action.effect.parameters.action_write.position_x = argument->value_double;
                                }
                                if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                    action->action.effect.parameters.action_write.position_y = argument->value_double;
                                    if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                        action->action.effect.parameters.action_write.zoom = argument->value_double;
                                        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
                                            action->action.effect.parameters.action_write.font_ID = (int)argument->value_double;
                                            if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
                                                action->action.effect.parameters.action_write.font_style = (int)argument->value_double;
                                        }
                                    }
                                }
                            }
                        }
                    }
                default:
                    break;
            }
            d_call(director, m_director_push_action, action);
        }
    }
    va_end(parameters_list);
}

struct s_lisp_object *p_link_effecteer_add_effect(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_effecteer(e_effecteer_action_add, d_lisp_car(arguments), d_lisp_cadr(arguments), d_lisp_caddr(arguments), d_lisp_caddr(d_lisp_cdr(arguments)),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(arguments))), d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments)))),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments))))), 
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments)))))));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_effecteer_play_effect(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_effecteer(e_effecteer_action_play, d_lisp_car(arguments), d_lisp_cadr(arguments), d_lisp_caddr(arguments), d_lisp_caddr(d_lisp_cdr(arguments)),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(arguments))), d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments)))));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_effecteer_write_effect(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_effecteer(e_effecteer_action_write, d_lisp_car(arguments), d_lisp_cadr(arguments), d_lisp_caddr(arguments), d_lisp_caddr(d_lisp_cdr(arguments)),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(arguments))), d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments)))),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments))))),
            d_lisp_caddr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(d_lisp_cdr(arguments)))))));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_effecteer_stop_effect(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_effecteer(e_effecteer_action_stop, d_lisp_car(arguments));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_effecteer_delete_effect(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_effecteer(e_effecteer_action_delete, d_lisp_car(arguments));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_effecteer_attributes *p_effecteer_alloc(struct s_object *self) {
    struct s_effecteer_attributes *result = d_prepare(self, effecteer);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_effecteer_new(struct s_object *self, struct s_object *factory) {
    struct s_effecteer_attributes *attributes = p_effecteer_alloc(self);
    attributes->factory = d_retain(factory);
    return self;
}

d_define_method(effecteer, get_effect)(struct s_object *self, const char *key) {
    d_using(effecteer);
    struct s_effecteer_effect *current_effect = NULL; 
    d_foreach(&(effecteer_attributes->components), current_effect, struct s_effecteer_effect)
        if (f_string_strcmp(current_effect->key, key) == 0)
            break;
    d_cast_return(current_effect);
}

d_define_method(effecteer, add_effect)(struct s_object *self, const char *key, const char *label, double position_x, double position_y, t_boolean absolute,
        double zoom, double angle, int layer) {
    d_using(effecteer);
    struct s_factory_attributes *factory_attributes = d_cast(effecteer_attributes->factory, factory);
    struct s_object *result = self;
    struct s_object *drawable;
    enum e_factory_media_types type;
    struct s_effecteer_effect *current_effect;
    double current_width, current_height;
    if ((drawable = d_call(effecteer_attributes->factory, m_factory_get_media, label, &type))) {
        if ((current_effect = (struct s_effecteer_effect *) d_malloc(sizeof(struct s_effecteer_effect)))) {
            strncpy(current_effect->key, key, d_entity_label_size);
            current_effect->drawable = drawable;
            current_effect->type = type;
            current_effect->position_x = position_x;
            current_effect->position_y = position_y;
            current_effect->absolute = absolute;
            current_effect->zoom = zoom;
            current_effect->angle = angle;
            current_effect->layer = layer;
            d_call(current_effect->drawable, m_drawable_get_dimension, &current_width, &current_height);
            d_call(current_effect->drawable, m_drawable_set_center, (current_width / 2.0), (current_height / 2.0));
            d_call(current_effect->drawable, m_drawable_set_position, current_effect->position_x, current_effect->position_y);
            d_call(current_effect->drawable, m_drawable_set_angle, current_effect->angle);
            d_call(current_effect->drawable, m_drawable_set_zoom, current_effect->zoom);
            d_call(factory_attributes->environment, m_environment_add_drawable, current_effect->drawable, current_effect->layer,
                    (current_effect->absolute)?e_environment_surface_ui:e_environment_surface_primary);
            switch (current_effect->type) {
                case e_factory_media_type_animation:
                    /* start the animation */
                    d_call(current_effect->drawable, m_animation_set_status, e_animation_direction_forward);
                    break;
                case e_factory_media_type_transition:
                    /* start the transition */
                    d_call(current_effect->drawable, m_transition_set_status, e_transition_direction_forward);
                    break;
                default:
                    break;
            }
            f_list_append(&(effecteer_attributes->components), (struct s_list_node *)current_effect, e_list_insert_head);
        } else
            d_die(d_error_malloc);
    } else
        result = NULL;
    return result;
}

d_define_method(effecteer, play_effect)(struct s_object *self, const char *key, const char *label, int fade_in, int fade_out, int volume, t_boolean loop) {
    d_using(effecteer);
    int index, unused_slot;
    for (index = 0, unused_slot = 0; index < d_effecteer_default_max_tracks; ++index)
        if (effecteer_attributes->tracks[index].track) {
            if (!d_call(effecteer_attributes->tracks[index].track, m_track_is_playing, NULL))
                unused_slot = index;
        } else
            break;
    if (index == d_effecteer_default_max_tracks)
        index = unused_slot;
    if (effecteer_attributes->tracks[index].track) {
        d_delete(effecteer_attributes->tracks[index].track);
        effecteer_attributes->tracks[index].track = NULL;
    }
    if ((effecteer_attributes->tracks[index].track = d_call(effecteer_attributes->factory, m_factory_get_track, label))) {
        strncpy(effecteer_attributes->tracks[index].key, key, d_resources_key_size);
        effecteer_attributes->tracks[index].fade_in = fade_in;
        effecteer_attributes->tracks[index].fade_out = fade_out;
        effecteer_attributes->tracks[index].volume = volume;
        effecteer_attributes->tracks[index].loop = loop;
        if (!v_developer_mode) {
            d_call(effecteer_attributes->tracks[index].track, m_track_set_volume, (effecteer_attributes->tracks[index].volume * d_pomodoro_general_volume));
            d_call(effecteer_attributes->tracks[index].track, m_track_set_loops, ((effecteer_attributes->tracks[index].loop)?d_track_infinite_loop:0));
            d_call(effecteer_attributes->tracks[index].track, m_track_play_fade_in, d_true, effecteer_attributes->tracks[index].fade_in);
        }
    }
    return self;
}

d_define_method(effecteer, write_effect)(struct s_object *self, const char *key, char *message, double position_x, double position_y, double zoom, 
        int font_ID, int font_style, int layer) {
    d_using(effecteer);
    struct s_factory_attributes *factory_attributes = d_cast(effecteer_attributes->factory, factory);
    double final_position_x;
    int index, font_height;
    TTF_Font *selected_font;
    for (index = 0; index < d_effecteer_default_max_labels; ++index)
        if (!effecteer_attributes->labels[index].drawable)
            break;
    if (index == d_effecteer_default_max_labels)
        index = 0;
    if (effecteer_attributes->labels[index].drawable) {
        d_call(factory_attributes->environment, m_environment_del_drawable, effecteer_attributes->labels[index].drawable,
                effecteer_attributes->labels[index].layer, e_environment_surface_ui);
        d_delete(effecteer_attributes->labels[index].drawable);
        effecteer_attributes->labels[index].drawable = NULL;
    }
    if ((selected_font = (TTF_Font *)d_call(effecteer_attributes->factory, m_factory_get_font, font_ID, font_style, &font_height)))
        if ((effecteer_attributes->labels[index].drawable = f_label_new(d_new(label), message, selected_font, factory_attributes->environment))) {
            strncpy(effecteer_attributes->labels[index].key, key, d_entity_label_size);
            effecteer_attributes->labels[index].position_x = position_x;
            effecteer_attributes->labels[index].position_y = position_y;
            effecteer_attributes->labels[index].zoom = zoom;
            effecteer_attributes->labels[index].layer = layer;
            d_call(effecteer_attributes->labels[index].drawable, m_drawable_set_zoom, effecteer_attributes->labels[index].zoom);
            if ((final_position_x = effecteer_attributes->labels[index].position_x) != effecteer_attributes->labels[index].position_x) {
                d_call(effecteer_attributes->labels[index].drawable, m_drawable_set_dimension_w, (double)(d_pomodoro_width * d_pomodoro_scale_factor));
                d_call(effecteer_attributes->labels[index].drawable, m_label_set_alignment, e_label_alignment_center, e_label_alignment_top);
                final_position_x = 0.0;
            }
            d_call(effecteer_attributes->labels[index].drawable, m_drawable_set_position, final_position_x, effecteer_attributes->labels[index].position_y);
            d_call(factory_attributes->environment, m_environment_add_drawable, effecteer_attributes->labels[index].drawable,
                    effecteer_attributes->labels[index].layer, e_environment_surface_ui);
        }
    return self;
}

d_define_method(effecteer, stop_effect)(struct s_object *self, const char *key) {
    d_using(effecteer);
    struct s_effecteer_effect *current_effect;
    int index;
    if ((current_effect = (struct s_effecteer_effect *)d_call(self, m_effecteer_get_effect, key))) {
        switch (current_effect->type) {
            case e_factory_media_type_particle:
                /* stop particle effect */
                d_call(current_effect->drawable, m_particle_stop, NULL);
                break;
            case e_factory_media_type_animation:
                /* stop animation */
                d_call(current_effect->drawable, m_animation_set_status, e_animation_direction_stop);
                break;
            case e_factory_media_type_transition:
                /* stop transition */
                d_call(current_effect->drawable, m_transition_set_status, e_transition_direction_stop);
            default:
                break;
        }
    } else {
        for (index = 0; index < d_effecteer_default_max_tracks; ++index) 
            if ((effecteer_attributes->tracks[index].track) && (f_string_strcmp(effecteer_attributes->tracks[index].key, key) == 0))
                d_call(effecteer_attributes->tracks[index].track, m_track_stop_fade_out, effecteer_attributes->tracks[index].fade_out);
    }
    return self;
}

d_define_method(effecteer, delete_effect)(struct s_object *self, const char *key) {
    d_using(effecteer);
    struct s_factory_attributes *factory_attributes = d_cast(effecteer_attributes->factory, factory);
    struct s_effecteer_effect *current_effect;
    int index;
    if ((current_effect = (struct s_effecteer_effect *)d_call(self, m_effecteer_get_effect, key))) {
        f_list_delete(&(effecteer_attributes->components), (struct s_list_node *)current_effect);
        d_call(factory_attributes->environment, m_environment_del_drawable, current_effect->drawable, current_effect->layer,
                (current_effect->absolute)?e_environment_surface_ui:e_environment_surface_primary);
        d_delete(current_effect->drawable);
        d_free(current_effect);
    }
    for (index = 0; index < d_effecteer_default_max_tracks; ++index)
        if ((effecteer_attributes->tracks[index].track) && (f_string_strcmp(effecteer_attributes->tracks[index].key, key) == 0)) {
            d_delete(effecteer_attributes->tracks[index].track);
            effecteer_attributes->tracks[index].track = NULL;
        }
    for (index = 0; index < d_effecteer_default_max_labels; ++index)
        if ((effecteer_attributes->labels[index].drawable) && (f_string_strcmp(effecteer_attributes->labels[index].key, key) == 0)) {
            d_call(factory_attributes->environment, m_environment_del_drawable, effecteer_attributes->labels[index].drawable, 
                    effecteer_attributes->labels[index].layer, e_environment_surface_ui);
            d_delete(effecteer_attributes->labels[index].drawable);
            effecteer_attributes->labels[index].drawable = NULL;
        }
    return self;
}

d_define_method(effecteer, linker)(struct s_object *self, struct s_object *script) {
    d_call(script, m_lisp_extend_environment, "effecteer_add", p_lisp_object(script, e_lisp_object_type_primitive, p_link_effecteer_add_effect));
    d_call(script, m_lisp_extend_environment, "effecteer_play", p_lisp_object(script, e_lisp_object_type_primitive, p_link_effecteer_play_effect));
    d_call(script, m_lisp_extend_environment, "effecteer_write", p_lisp_object(script, e_lisp_object_type_primitive, p_link_effecteer_write_effect));
    d_call(script, m_lisp_extend_environment, "effecteer_stop", p_lisp_object(script, e_lisp_object_type_primitive, p_link_effecteer_stop_effect));
    d_call(script, m_lisp_extend_environment, "effecteer_delete", p_lisp_object(script, e_lisp_object_type_primitive, p_link_effecteer_delete_effect));
    return self;
}

d_define_method(effecteer, dispatcher)(struct s_object *self, struct s_effecteer_action *action) {
    struct s_object *result = NULL;
    switch (action->type) {
        case e_effecteer_action_add:            /* key (effect), label (effect), position_x, position_y, zoom, angle, 
                                                   absolute (camera/scenario reference), front (top/back layer) */
            d_log(e_log_level_medium, "action [add] (effect %s (%s) | destination %.02f, %.02f (%s) | zoom %.02f | angle %.02f | %s)", action->key, 
                    action->parameters.action_add.label, action->parameters.action_add.position_x, action->parameters.action_add.position_y, 
                    ((action->parameters.action_add.absolute)?"absolute":"relative"), action->parameters.action_add.zoom, action->parameters.action_add.angle,
                    ((action->parameters.action_add.front)?"front":"back"));
            result = d_call(self, m_effecteer_add_effect, action->key, action->parameters.action_add.label, action->parameters.action_add.position_x,
                    action->parameters.action_add.position_y, action->parameters.action_add.absolute, action->parameters.action_add.zoom,
                    action->parameters.action_add.angle, (action->parameters.action_add.front)?d_effecteer_default_front_layer:d_effecteer_default_back_layer);
            break;
        case e_effecteer_action_play:           /* key (effect), label (effect), fade_in (time), fade_out (time), volume, loop */
            d_log(e_log_level_medium, "action [play] (effect %s (%s) | fade_in %d | fade out %d | volume %d | %s)", action->key,
                    action->parameters.action_play.label, action->parameters.action_play.fade_in, action->parameters.action_play.fade_out,
                    action->parameters.action_play.volume, (action->parameters.action_play.loop)?"loop":"single");
            result = d_call(self, m_effecteer_play_effect, action->key, action->parameters.action_play.label, action->parameters.action_play.fade_in, 
                    action->parameters.action_play.fade_out, action->parameters.action_play.volume, action->parameters.action_play.loop);
            break;
        case e_effecteer_action_write:          /* key (effect), content (string), layer, position_x, position_y, zoom, font_ID, font_style */
            d_log(e_log_level_medium, "action [write] (effect %s (%s) | destination %.02f, %.02f | zoom %.02f | layer %d)", action->key,
                    action->parameters.action_write.label, action->parameters.action_write.position_x, action->parameters.action_write.position_y,
                    action->parameters.action_write.zoom, action->parameters.action_write.layer);
            result = d_call(self, m_effecteer_write_effect, action->key, action->parameters.action_write.label, action->parameters.action_write.position_x, 
                    action->parameters.action_write.position_y, action->parameters.action_write.zoom, action->parameters.action_write.font_ID,
                    action->parameters.action_write.font_style, action->parameters.action_write.layer);
            break;
        case e_effecteer_action_stop:           /* key (effect) */
            d_log(e_log_level_medium, "action [stop] (effect %s)", action->key);
            result = d_call(self, m_effecteer_stop_effect, action->key);
            break;

        case e_effecteer_action_delete:         /* key (effect) */
            d_log(e_log_level_medium, "action [delete] (effect %s)", action->key);
            result = d_call(self, m_effecteer_delete_effect, action->key);
            break;
    }
    return self;
}

d_define_method(effecteer, delete)(struct s_object *self, struct s_effecteer_attributes *attributes) {
    struct s_factory_attributes *factory_attributes = d_cast(attributes->factory, factory);
    struct s_effecteer_effect *current_effect;
    int index;
    while ((current_effect = (struct s_effecteer_effect *)(attributes->components.head))) {
        f_list_delete(&(attributes->components), (struct s_list_node *)current_effect);
        d_call(factory_attributes->environment, m_environment_del_drawable, current_effect->drawable, current_effect->layer,
                (current_effect->absolute)?e_environment_surface_ui:e_environment_surface_primary);
        d_delete(current_effect->drawable);
        d_free(current_effect);
    }
    for (index = 0; index < d_effecteer_default_max_tracks; ++index) 
        if (attributes->tracks[index].track)
            d_delete(attributes->tracks[index].track);
    for (index = 0; index < d_effecteer_default_max_labels; ++index)
        if (attributes->labels[index].drawable) {
            d_call(factory_attributes->environment, m_environment_del_drawable, attributes->labels[index].drawable, 
                    attributes->labels[index].layer, e_environment_surface_ui);
            d_delete(attributes->labels[index].drawable);
            attributes->labels[index].drawable = NULL;
        }
    d_delete(attributes->factory);
    return NULL;
}

d_define_class(effecteer) {
    d_hook_method(effecteer, e_flag_private, get_effect),
        d_hook_method(effecteer, e_flag_public, add_effect),
        d_hook_method(effecteer, e_flag_public, play_effect),
        d_hook_method(effecteer, e_flag_public, write_effect),
        d_hook_method(effecteer, e_flag_public, stop_effect),
        d_hook_method(effecteer, e_flag_public, delete_effect),
        d_hook_method(effecteer, e_flag_public, linker),
        d_hook_method(effecteer, e_flag_public, dispatcher),
        d_hook_delete(effecteer),
        d_hook_method_tail
};
