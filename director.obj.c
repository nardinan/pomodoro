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
#include "director.obj.h"
#define d_pomodoro_width_offset 50
struct s_object *director = NULL;
void p_link_director(enum e_director_actions type, ...) {
    va_list parameters_list;
    struct s_director_action *action;
    struct s_lisp_object *argument;
    va_start(parameters_list, type);
    if ((action = d_call(director, m_director_new_action, type))) {
        switch (action->type) {
            case e_director_action_service_sleep:
                if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
                    action->action.delay = argument->value_double;
                break;
            case e_director_action_service_script:
                if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
                    strncpy(action->action.label, argument->value_string, d_resources_key_size);
            default:
                break;
        }
        d_call(director, m_director_push_action, action);
    }
    va_end(parameters_list);
}

struct s_lisp_object *p_link_director_sleep(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_director(e_director_action_service_sleep, d_lisp_car(arguments));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

struct s_lisp_object *p_link_director_script(struct s_object *self, struct s_lisp_object *arguments) {
    d_using(lisp);
    p_link_director(e_director_action_service_script, d_lisp_car(arguments));
    return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}

t_boolean f_director_validator(struct s_object *self, double current_x, double current_y, double current_zoom, double *new_x, double *new_y, 
        double *new_zoom) {
    /* TODO: the system that corrects the Y coordinate and adjust the camera has to be developed */
    if (*new_x < (0 - d_pomodoro_width_offset))
        *new_x = d_pomodoro_width + d_pomodoro_width_offset;
    else if (*new_x > (d_pomodoro_width + d_pomodoro_width_offset))
        *new_x = (0 - d_pomodoro_width_offset);
    *new_y = 550.0;
    return d_true;
}

struct s_director_attributes *p_director_alloc(struct s_object *self) {
    struct s_director_attributes *result = d_prepare(self, director);
    f_memory_new(self);         /* inherit */
    f_mutex_new(self);          /* inherit */
    return result;
}

struct s_object *f_director_new(struct s_object *self, struct s_object *factory) {
    struct s_director_attributes *attributes = p_director_alloc(self);
    attributes->factory = d_retain(factory);
    d_assert(attributes->puppeteer = f_puppeteer_new(d_new(puppeteer), factory, f_director_validator));
    d_assert(attributes->effecteer = f_effecteer_new(d_new(effecteer), factory));
    return self;
}

d_define_method(director, new_action)(struct s_object *self, enum e_director_actions type) {
    struct s_director_action *action;
    if ((action = (struct s_director_action *)d_malloc(sizeof(struct s_director_action)))) {
        action->creation_time = time(NULL);
        action->type = type;
    } else
        d_die(d_error_malloc);
    d_cast_return(action);
}

d_define_method(director, push_action)(struct s_object *self, struct s_director_action *action) {
    d_using(director);
    action->pushing_time = time(NULL);
    f_list_append(&(director_attributes->actions_pool), (struct s_list_node *)action, e_list_insert_tail);
    return self;
}

d_define_method(director, update)(struct s_object *self) {
    d_using(director);
    struct s_director_action *current_action;
    if (time(NULL) > director_attributes->alive)
        if ((current_action = (struct s_director_action *)director_attributes->actions_pool.head)) {
            f_list_delete(&(director_attributes->actions_pool), (struct s_list_node *)current_action);
            current_action->execution_time = time(NULL);
            d_call(self, m_director_dispatcher, current_action);
            d_free(current_action);
        }
    return self;
}

d_define_method(director, run_script)(struct s_object *self, const char *label) {
    d_using(director);
    struct s_object *current_script;
    if ((current_script = d_call(director_attributes->factory, m_factory_get_script, label))) {
        d_call(self, m_director_linker, current_script);
        d_call(current_script, m_lisp_run, NULL);
        d_delete(current_script);
    }
    return self;
}

d_define_method(director, linker)(struct s_object *self, struct s_object *script) {
    d_using(director);
    d_call(script, m_lisp_extend_environment, "director_wait", p_lisp_object(script, e_lisp_object_type_primitive, p_link_director_sleep));
    d_call(script, m_lisp_extend_environment, "director_script", p_lisp_object(script, e_lisp_object_type_primitive, p_link_director_script));
    d_call(director_attributes->puppeteer, m_puppeteer_linker, script);
    d_call(director_attributes->effecteer, m_effecteer_linker, script);
    return self;
}

d_define_method(director, dispatcher)(struct s_object *self, struct s_director_action *action) {
    d_using(director);
    struct s_object *result = NULL;
    switch (action->type) {
        case e_director_action_puppeteer:
            d_call(director_attributes->puppeteer, m_puppeteer_dispatcher, &(action->action.character));
            break;
        case e_director_action_effecteer:
            d_call(director_attributes->effecteer, m_effecteer_dispatcher, &(action->action.effect));
            break;
        case e_director_action_service_sleep:       /* timeout */
            director_attributes->alive = time(NULL) + action->action.delay;
            result = self;
            break;
        case e_director_action_service_script:      /* label (script name) */
            d_call(self, m_director_run_script, action->action.label);
        default:
            break;
    }
    return self;
}

d_define_method(director, delete)(struct s_object *self, struct s_director_attributes *attributes) {
    struct s_director_action *current_action;
    d_delete(attributes->factory);
    d_delete(attributes->puppeteer);
    d_delete(attributes->effecteer);
    while ((current_action = (struct s_director_action *)attributes->actions_pool.head)) {
        f_list_delete(&(attributes->actions_pool), (struct s_list_node *)current_action);
        d_free(current_action);
    }
    return NULL;
}

d_define_class(director) {
    d_hook_method(director, e_flag_public, new_action),
        d_hook_method(director, e_flag_public, push_action),
        d_hook_method(director, e_flag_public, update),
        d_hook_method(director, e_flag_public, run_script),
        d_hook_method(director, e_flag_public, linker),
        d_hook_method(director, e_flag_public, dispatcher),
        d_hook_delete(director),
        d_hook_method_tail
};

