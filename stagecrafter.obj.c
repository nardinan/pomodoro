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
#include "stagecrafter.obj.h"
#include "director.obj.h"
void p_link_stagecrafter(enum e_stagecrafter_actions type, ...) {
  va_list parameters_list;
  struct s_director_action *action;
  struct s_lisp_object *argument;
  va_start(parameters_list, type);
  if ((action = d_call(director, m_director_new_action, e_director_action_stagecrafter))) {
    switch ((action->action.landscape.type = type)) {
      case e_stagecrafter_action_show:
      case e_stagecrafter_action_play:
      case e_stagecrafter_action_lock:
      case e_stagecrafter_action_unlock:
      case e_stagecrafter_action_enable:
      case e_stagecrafter_action_disable:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
          strncpy(action->action.landscape.key, argument->value_string, d_entity_label_size);
        break;
      case e_stagecrafter_action_set:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.landscape.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
            strncpy(action->action.landscape.parameters.entry, argument->value_string, d_entity_label_size);
        }
        break;
      default:
        break;
    }
    d_call(director, m_director_push_action, action);
  }
  va_end(parameters_list);
}
struct s_lisp_object *p_link_stagecrafter_hide_landscapes(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_hide);
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_show_landscape(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_show, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_stop_tracks(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_stop);
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_play_track(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_play, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_lock_item(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_lock, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_unlock_item(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_unlock, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_enable_item(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_enable, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_disable_item(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_disable, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_stagecrafter_set_item(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_stagecrafter(e_stagecrafter_action_set, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_stagecrafter_attributes *p_stagecrafter_alloc(struct s_object *self) {
  struct s_stagecrafter_attributes *result = d_prepare(self, stagecrafter);
  f_memory_new(self); /* inherit */
  f_mutex_new(self);  /* inherit */
  return result;
}
struct s_object *f_stagecrafter_new(struct s_object *self, struct s_object *factory) {
  struct s_stagecrafter_attributes *attributes = p_stagecrafter_alloc(self);
  struct s_factory_attributes *factory_attributes = d_cast(factory, factory);
  struct s_stagecrafter_landscape *current_landscape;
  struct s_object *json;
  char *name_buffer, *link_buffer;
  int landscape_index = 0;
  attributes->factory = d_retain(factory);
  while ((d_call(factory_attributes->json_configuration, m_json_get_string, &name_buffer, "sds", "landscapes", landscape_index, "label"))) {
    d_call(factory_attributes->json_configuration, m_json_get_string, &link_buffer, "sds", "landscapes", landscape_index, "link");
    if ((current_landscape = (struct s_stagecrafter_landscape *) d_malloc(sizeof(struct s_stagecrafter_landscape)))) {
      strncpy(current_landscape->label, name_buffer, d_entity_label_size);
      current_landscape->landscape = f_landscape_new(d_new(landscape), current_landscape->label);
      if ((json = d_call(attributes->factory, m_factory_get_json, link_buffer))) {
        d_call(current_landscape->landscape, m_landscape_load, json, attributes->factory);
        d_delete(json);
      }
      f_list_append(&(attributes->landscapes), (struct s_list_node *) current_landscape, e_list_insert_head);
    } else
      d_die(d_error_malloc);
    ++landscape_index;
  }
  return self;
}
d_define_method(stagecrafter, get_landscape)(struct s_object *self, const char *key) {
  d_using(stagecrafter);
  struct s_stagecrafter_landscape *current_landscape;
  struct s_object *result = NULL;
  d_foreach(&(stagecrafter_attributes->landscapes), current_landscape, struct s_stagecrafter_landscape)if (f_string_strcmp(current_landscape->label, key) ==
                                                                                                           0) {
      result = current_landscape->landscape;
      break;
    }
  return result;
}
d_define_method(stagecrafter, hide_landscapes)(struct s_object *self) {
  d_using(stagecrafter);
  struct s_factory_attributes *factory_attributes = d_cast(stagecrafter_attributes->factory, factory);
  struct s_landscape_attributes *landscape_attributes;
  struct s_stagecrafter_landscape *current_landscape;
  if (stagecrafter_attributes->main_landscape) {
    landscape_attributes = d_cast(stagecrafter_attributes->main_landscape, landscape);
    if (landscape_attributes->outro_script[0])
      d_call(director, m_director_run_script, landscape_attributes->outro_script);
    stagecrafter_attributes->main_landscape = NULL;
  }
  d_foreach(&(stagecrafter_attributes->landscapes), current_landscape, struct s_stagecrafter_landscape)d_call(current_landscape->landscape, m_landscape_hide,
                                                                                                              factory_attributes->environment);
  return self;
}
d_define_method(stagecrafter, show_landscape)(struct s_object *self, const char *key) {
  d_using(stagecrafter);
  struct s_factory_attributes *factory_attributes = d_cast(stagecrafter_attributes->factory, factory);
  struct s_landscape_attributes *landscape_attributes;
  struct s_object *current_landscape;
  d_call(self, m_stagecrafter_hide_landscapes, NULL);
  if ((current_landscape = d_call(self, m_stagecrafter_get_landscape, key))) {
    stagecrafter_attributes->main_landscape = current_landscape;
    landscape_attributes = d_cast(stagecrafter_attributes->main_landscape, landscape);
    if (landscape_attributes->intro_script[0])
      d_call(director, m_director_run_script, landscape_attributes->intro_script);
    d_call(current_landscape, m_landscape_show, factory_attributes->environment);
  }
  return self;
}
d_define_method(stagecrafter, get_main_landscape)(struct s_object *self) {
  d_using(stagecrafter);
  return stagecrafter_attributes->main_landscape;
}
d_define_method(stagecrafter, stop_tracks)(struct s_object *self) {
  d_using(stagecrafter);
  if (stagecrafter_attributes->main_landscape)
    d_call(stagecrafter_attributes->main_landscape, m_landscape_stop, NULL);
  return self;
}
d_define_method(stagecrafter, play_track)(struct s_object *self, const char *key) {
  d_using(stagecrafter);
  if (stagecrafter_attributes->main_landscape)
    d_call(stagecrafter_attributes->main_landscape, m_landscape_play, key);
  return self;
}
d_define_method(stagecrafter, set_item_solid)(struct s_object *self, const char *key, t_boolean solid) {
  d_using(stagecrafter);
  if (stagecrafter_attributes->main_landscape)
    d_call(stagecrafter_attributes->main_landscape, m_landscape_set_item_solid, key, solid);
  return self;
}
d_define_method(stagecrafter, set_item_active)(struct s_object *self, const char *key, t_boolean active) {
  d_using(stagecrafter);
  if (stagecrafter_attributes->main_landscape)
    d_call(stagecrafter_attributes->main_landscape, m_landscape_set_item_active, key, active);
  return self;
}
d_define_method(stagecrafter, set_item_status)(struct s_object *self, const char *key, const char *status) {
  d_using(stagecrafter);
  struct s_object *landscape = NULL;
  if ((landscape = stagecrafter_attributes->main_landscape))
    d_call(stagecrafter_attributes->main_landscape, m_landscape_set_item_status, key, status);
  return landscape;
}
d_define_method(stagecrafter, get_dimension)(struct s_object *self, double *dimension_w, double *dimension_h) {
  d_using(stagecrafter);
  struct s_object *landscape = NULL;
  if ((landscape = stagecrafter_attributes->main_landscape))
    d_call(stagecrafter_attributes->main_landscape, m_landscape_get_dimension, dimension_w, dimension_h);
  return landscape;
}
d_define_method(stagecrafter, update)(struct s_object *self) {
  d_using(stagecrafter);
  struct s_factory_attributes *factory_attributes;
  struct s_landscape_script *current_script;
  if (stagecrafter_attributes->main_landscape) {
    factory_attributes = d_cast(stagecrafter_attributes->factory, factory);
    if ((current_script = (struct s_landscape_script *) d_call(stagecrafter_attributes->main_landscape, m_landscape_update, factory_attributes->environment)))
      d_call(director, m_director_run_script, current_script->script);
  }
  return self;
}
d_define_method(stagecrafter, linker)(struct s_object *self, struct s_object *script) {
  d_call(script, m_lisp_extend_environment, "stagecrafter_hide", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_hide_landscapes));
  d_call(script, m_lisp_extend_environment, "stagecrafter_show", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_show_landscape));
  d_call(script, m_lisp_extend_environment, "stagecrafter_stop", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_stop_tracks));
  d_call(script, m_lisp_extend_environment, "stagecrafter_play", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_play_track));
  d_call(script, m_lisp_extend_environment, "stagecrafter_lock_item", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_lock_item));
  d_call(script, m_lisp_extend_environment, "stagecrafter_unlock_item", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_unlock_item));
  d_call(script, m_lisp_extend_environment, "stagecrafter_enable_item", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_enable_item));
  d_call(script, m_lisp_extend_environment, "stagecrafter_disable_item", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_disable_item));
  d_call(script, m_lisp_extend_environment, "stagecrafter_set_item", p_lisp_object(script, e_lisp_object_type_primitive, p_link_stagecrafter_set_item));
  return self;
}
d_define_method(stagecrafter, dispatcher)(struct s_object *self, struct s_stagecrafter_action *action) {
  struct s_object *result = NULL;
  switch (action->type) {
    case e_stagecrafter_action_hide:        /* no parameters */
      d_log(e_log_level_medium, "action [hide]");
      result = d_call(self, m_stagecrafter_hide_landscapes, NULL);
      break;
    case e_stagecrafter_action_show:        /* key (landscape) */
      d_log(e_log_level_medium, "action [show] (landscape %s)", action->key);
      result = d_call(self, m_stagecrafter_show_landscape, action->key);
      break;
    case e_stagecrafter_action_stop:        /* no parameters */
      d_log(e_log_level_medium, "action [stop]");
      result = d_call(self, m_stagecrafter_stop_tracks, NULL);
      break;
    case e_stagecrafter_action_play:        /* key (track) */
      d_log(e_log_level_medium, "action [play] (track %s)", action->key);
      result = d_call(self, m_stagecrafter_play_track, action->key);
      break;
    case e_stagecrafter_action_lock:        /* key (item) */
    case e_stagecrafter_action_unlock:
      d_log(e_log_level_medium, "action [lock_item/unlock_item] (item %s)", action->key);
      result = d_call(self, m_stagecrafter_set_item_solid, action->key, (t_boolean) (action->type == e_stagecrafter_action_lock));
      break;
    case e_stagecrafter_action_enable:      /* key (item) */
    case e_stagecrafter_action_disable:
      d_log(e_log_level_medium, "action [enable_item/disable_item] (item %s)", action->key);
      result = d_call(self, m_stagecrafter_set_item_active, action->key, (t_boolean) (action->type == e_stagecrafter_action_enable));
      break;
    case e_stagecrafter_action_set:         /* key (item), entry (status) */
      d_log(e_log_level_medium, "action [set] (item %s | status %s)", action->key, action->parameters.entry);
      result = d_call(self, m_stagecrafter_set_item_status, action->key, action->parameters.entry);
      break;
  }
  return result;
}
d_define_method(stagecrafter, delete)(struct s_object *self, struct s_stagecrafter_attributes *attributes) {
  struct s_stagecrafter_landscape *current_landscape;
  d_delete(attributes->factory);
  while ((current_landscape = (struct s_stagecrafter_landscape *) attributes->landscapes.head)) {
    f_list_delete(&(attributes->landscapes), (struct s_list_node *) current_landscape);
    d_delete(current_landscape->landscape);
    d_free(current_landscape);
  }
  return NULL;
}
d_define_class(stagecrafter) {d_hook_method(stagecrafter, e_flag_public, get_landscape),
                              d_hook_method(stagecrafter, e_flag_public, hide_landscapes),
                              d_hook_method(stagecrafter, e_flag_public, show_landscape),
                              d_hook_method(stagecrafter, e_flag_public, get_main_landscape),
                              d_hook_method(stagecrafter, e_flag_public, stop_tracks),
                              d_hook_method(stagecrafter, e_flag_public, play_track),
                              d_hook_method(stagecrafter, e_flag_public, set_item_solid),
                              d_hook_method(stagecrafter, e_flag_public, set_item_active),
                              d_hook_method(stagecrafter, e_flag_public, set_item_status),
                              d_hook_method(stagecrafter, e_flag_public, get_dimension),
                              d_hook_method(stagecrafter, e_flag_public, update),
                              d_hook_method(stagecrafter, e_flag_public, linker),
                              d_hook_method(stagecrafter, e_flag_public, dispatcher),
                              d_hook_delete(stagecrafter),
                              d_hook_method_tail};
