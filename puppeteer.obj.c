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
#include "director.obj.h"
void p_link_puppeteer(enum e_puppeteer_actions type, ...) {
  va_list parameters_list;
  struct s_director_action *action;
  struct s_lisp_object *argument;
  va_start(parameters_list, type);
  if ((action = d_call(director, m_director_new_action, e_director_action_puppeteer))) {
    switch ((action->action.character.type = type)) {
      case e_puppeteer_action_enable_control:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
        break;
      case e_puppeteer_action_say:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
            strncpy(action->action.character.parameters.action_say.message, argument->value_string, d_string_buffer_size);
            if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
              action->action.character.parameters.action_say.timeout = argument->value_double;
          }
        }
        break;
      case e_puppeteer_action_talk:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
            strncpy(action->action.character.parameters.action_talk.message, argument->value_string, d_string_buffer_size);
            if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
              strncpy(action->action.character.parameters.action_talk.track, argument->value_string, d_resources_key_size);
          }
        }
        break;
      case e_puppeteer_action_set:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
            strncpy(action->action.character.parameters.entry, argument->value_string, d_string_buffer_size);
        }
        break;
      case e_puppeteer_action_move:
      case e_puppeteer_action_run:
      case e_puppeteer_action_show:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
            action->action.character.parameters.destination_x = argument->value_double;
        }
        break;
      case e_puppeteer_action_look:
      case e_puppeteer_action_stare:
        if ((argument = va_arg(parameters_list, struct s_lisp_object *))) {
          strncpy(action->action.character.key, argument->value_string, d_entity_label_size);
          if ((argument = va_arg(parameters_list, struct s_lisp_object *)))
            strncpy(action->action.character.parameters.entity, argument->value_string, d_entity_label_size);
        }
      default:
        break;
    }
    d_call(director, m_director_push_action, action);
  }
  va_end(parameters_list);
}
struct s_lisp_object *p_link_puppeteer_hide_characters(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_hide);
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_show_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_show, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_enable_control(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_enable_control, d_lisp_car(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_disable_control(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_disable_control);
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_say_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_say, d_lisp_car(arguments), d_lisp_cadr(arguments), d_lisp_caddr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_talk_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_talk, d_lisp_car(arguments), d_lisp_cadr(arguments), d_lisp_caddr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_set_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_set, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_move_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_move, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_run_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_run, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_look_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_look, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_stare_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  p_link_puppeteer(e_puppeteer_action_stare, d_lisp_car(arguments), d_lisp_cadr(arguments));
  return lisp_attributes->base_symbols[e_lisp_object_symbol_true];
}
struct s_lisp_object *p_link_puppeteer_get_position_character(struct s_object *self, struct s_lisp_object *arguments) {
  d_using(lisp);
  struct s_lisp_object *label_object = d_lisp_car(arguments), *result = lisp_attributes->base_symbols[e_lisp_object_symbol_nil];
  struct s_director_attributes *director_attributes = d_cast(director, director);
  struct s_puppeteer_attributes *puppeteer_attributes = d_cast(director_attributes->puppeteer, puppeteer);
  struct s_puppeteer_character *current_character;
  double current_position_x, current_position_y;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (
      f_string_strcmp(current_character->label, label_object->value_string) == 0) {
      d_call(current_character->character, m_drawable_get_position, &current_position_x, &current_position_y);
      result = p_lisp_object(self, e_lisp_object_type_value, current_position_x);
      break;
    }
  return result;
}
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
  char *name_buffer, *link_buffer, *string_supply;
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
      if (d_call(factory_attributes->json_configuration, m_json_get_string, &string_supply, "sds", "characters", character_index, "script"))
        strncpy(current_character->script, string_supply, d_resources_key_size);
      current_character->character = f_character_new(d_new(character), current_character->label, validator);
      if ((json = d_call(attributes->factory, m_factory_get_json, link_buffer))) {
        d_call(current_character->character, m_character_load, json, attributes->factory);
        d_call(current_character->character, m_controllable_set, controllable);
        d_delete(json);
      }
      f_list_append(&(attributes->characters), (struct s_list_node *) current_character, e_list_insert_head);
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
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (f_string_strcmp(current_character->label, key) == 0) {
      result = current_character->character;
      break;
    }
  return result;
}
d_define_method(puppeteer, hide_characters)(struct s_object *self) {
  d_using(puppeteer);
  struct s_factory_attributes *factory_attributes = d_cast(puppeteer_attributes->factory, factory);
  struct s_puppeteer_character *current_character;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character) {
    current_character->visible = d_false;
    d_call(factory_attributes->environment, m_environment_del_drawable, current_character->character, d_puppeteer_default_layer, e_environment_surface_primary);
    d_call(self, m_puppeteer_stare_character, current_character->label, NULL);
    d_call(current_character->character, m_character_hide_bubble, factory_attributes->environment);
  }
  return self;
}
d_define_method(puppeteer, show_character)(struct s_object *self, const char *key, double position_x) {
  d_using(puppeteer);
  struct s_factory_attributes *factory_attributes = d_cast(puppeteer_attributes->factory, factory);
  struct s_puppeteer_character *current_character;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (f_string_strcmp(current_character->label, key) == 0) {
      if (position_x == d_puppeteer_void) {
        if (current_character->visible) {
          current_character->visible = d_false;
          d_call(factory_attributes->environment, m_environment_del_drawable, current_character->character, d_puppeteer_default_layer,
                 e_environment_surface_primary);
          d_call(current_character->character, m_character_hide_bubble, factory_attributes->environment);
        }
      } else {
        d_call(current_character->character, m_drawable_set_position_x, position_x);
        if (!current_character->visible) {
          current_character->visible = d_true;
          d_call(factory_attributes->environment, m_environment_add_drawable, current_character->character, d_puppeteer_default_layer,
                 e_environment_surface_primary);
          d_call(current_character->character, m_character_show_bubble, factory_attributes->environment);
        }
      }
      break;
    }
  return self;
}
d_define_method(puppeteer, enable_control)(struct s_object *self, const char *key) {
  d_using(puppeteer);
  struct s_object *current_character;
  d_call(self, m_puppeteer_disable_control, NULL);
  if ((current_character = d_call(self, m_puppeteer_get_character, key))) {
    puppeteer_attributes->main_character = current_character;
    d_call(current_character, m_controllable_set, d_true);
  }
  return self;
}
d_define_method(puppeteer, disable_control)(struct s_object *self) {
  d_using(puppeteer);
  struct s_puppeteer_character *current_character;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)d_call(current_character->character, m_controllable_set,
                                                                                                        d_false);
  return self;
}
d_define_method(puppeteer, say_character)(struct s_object *self, const char *key, const char *message, time_t timeout) {
  struct s_object *current_character;
  if ((current_character = d_call(self, m_puppeteer_get_character, key)))
    d_call(current_character, m_character_say, message, timeout);
  return self;
}
d_define_method(puppeteer, talk_character)(struct s_object *self, const char *key, const char *message, const char *track) {
  d_using(puppeteer);
  struct s_object *current_character;
  struct s_object *current_track;
  if ((current_character = d_call(self, m_puppeteer_get_character, key))) {
    if ((current_track = d_call(puppeteer_attributes->factory, m_factory_get_track, track))) {
      d_call(current_character, m_character_talk, message, current_track);
      d_delete(current_track);
    }
  }
  return self;
}
d_define_method(puppeteer, set_character)(struct s_object *self, const char *key, const char *entry) {
  struct s_object *current_character;
  if ((current_character = d_call(self, m_puppeteer_get_character, key))) {
    d_call(current_character, m_character_move_clean, d_true);
    d_call(current_character, m_entity_set_component, entry);
  }
  return self;
}
d_define_method(puppeteer, move_character)(struct s_object *self, const char *key, double destination_x, t_boolean run) {
  d_using(puppeteer);
  struct s_puppeteer_character *current_character;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (f_string_strcmp(current_character->label, key) == 0) {
      if (current_character->connected)
        d_delete(current_character->connected);
      current_character->connected = NULL;
      d_call(current_character->character, m_character_move, destination_x, run);
    }
  return self;
}
d_define_method(puppeteer, look_character)(struct s_object *self, const char *key, const char *entity) {
  d_using(puppeteer);
  struct s_puppeteer_character *current_character;
  struct s_object *destination_character;
  double current_position_x, destination_position_x, position_y;
  if ((destination_character = d_call(self, m_puppeteer_get_character, entity))) {
    d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (f_string_strcmp(current_character->label, key) == 0) {
        if (current_character->connected)
          d_delete(current_character->connected);
        current_character->connected = NULL;
        d_call(current_character->character, m_drawable_get_position, &current_position_x, &position_y);
        d_call(destination_character, m_drawable_get_position, &destination_position_x, &position_y);
        d_call(current_character->character, ((current_position_x < destination_position_x) ? m_character_move_right : m_character_move_left), NULL, d_false);
        break;
      }
  }
  return self;
}
d_define_method(puppeteer, stare_character)(struct s_object *self, const char *key, const char *entity) {
  d_using(puppeteer);
  struct s_puppeteer_character *current_character;
  struct s_object *destination_character = d_call(self, m_puppeteer_get_character, entity);
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character)if (f_string_strcmp(current_character->label, key) == 0) {
      if (current_character->connected) {
        d_delete(current_character->connected);
        current_character->connected = NULL;
      }
      current_character->connected = d_retain(destination_character);
      break;
    }
  return self;
}
d_define_method(puppeteer, get_main_character)(struct s_object *self) {
  d_using(puppeteer);
  return puppeteer_attributes->main_character;
}
d_define_method(puppeteer, update)(struct s_object *self) {
  d_using(puppeteer);
  struct s_puppeteer_character *current_character;
  double current_position_x, destination_position_x, position_y;
  d_foreach(&(puppeteer_attributes->characters), current_character, struct s_puppeteer_character) {
    if (current_character->connected) {
      d_call(current_character->character, m_drawable_get_position, &current_position_x, &position_y);
      d_call(current_character->connected, m_drawable_get_position, &destination_position_x, &position_y);
      d_call(current_character->character, ((current_position_x < destination_position_x) ? m_character_move_right : m_character_move_left), NULL, d_false);
    }
  }
  return self;
}
d_define_method(puppeteer, linker)(struct s_object *self, struct s_object *script) {
  d_call(script, m_lisp_extend_environment, "puppeteer_hide", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_hide_characters));
  d_call(script, m_lisp_extend_environment, "puppeteer_show", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_show_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_enable_control", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_enable_control));
  d_call(script, m_lisp_extend_environment, "puppeteer_disable_control", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_disable_control));
  d_call(script, m_lisp_extend_environment, "puppeteer_say", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_say_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_talk", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_talk_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_set", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_set_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_move", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_move_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_run", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_run_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_look", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_look_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_stare", p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_stare_character));
  d_call(script, m_lisp_extend_environment, "puppeteer_get_position",
         p_lisp_object(script, e_lisp_object_type_primitive, p_link_puppeteer_get_position_character));
  d_call(script, m_lisp_extend_environment, "the_void", p_lisp_object(script, e_lisp_object_type_value, d_puppeteer_void));
  return self;
}
d_define_method(puppeteer, dispatcher)(struct s_object *self, struct s_puppeteer_action *action) {
  struct s_object *result = NULL;
  switch (action->type) {
    case e_puppeteer_action_hide:               /* no parameters */
      d_log(e_log_level_medium, "action [hide]");
      result = d_call(self, m_puppeteer_hide_characters, NULL);
      break;
    case e_puppeteer_action_show:               /* key (character, destination_x */
      d_log(e_log_level_medium, "action [show] (character %s | destination %.02f)", action->key, action->parameters.destination_x);
      result = d_call(self, m_puppeteer_show_character, action->key, action->parameters.destination_x);
      break;
    case e_puppeteer_action_enable_control:     /* key (character) */
      d_log(e_log_level_medium, "action [enable control] (character %s)", action->key);
      result = d_call(self, m_puppeteer_enable_control, action->key);
      break;
    case e_puppeteer_action_disable_control:    /* no parameters */
      d_log(e_log_level_medium, "action [disable control]");
      result = d_call(self, m_puppeteer_disable_control, NULL);
      break;
    case e_puppeteer_action_say:                /* key (character), message, timeout */
      d_log(e_log_level_medium, "action [say] (character %s | message %s | timeout %.00f)", action->key, action->parameters.action_say.message,
            action->parameters.action_say.timeout);
      result = d_call(self, m_puppeteer_say_character, action->key, action->parameters.action_say.message, (time_t) action->parameters.action_say.timeout);
      break;
    case e_puppeteer_action_talk:
      d_log(e_log_level_medium, "action [talk] (character %s | message %s | track %s)", action->key, action->parameters.action_talk.message,
            action->parameters.action_talk.track);
      result = d_call(self, m_puppeteer_talk_character, action->key, action->parameters.action_talk.message, action->parameters.action_talk.track);
      break;
    case e_puppeteer_action_set:                /* key (character), entry (animation) */
      d_log(e_log_level_medium, "action [set] (character %s | animation %s)", action->key, action->parameters.entry);
      result = d_call(self, m_puppeteer_set_character, action->key, action->parameters.entry);
      break;
    case e_puppeteer_action_move:               /* key (character), destination_x */
      d_log(e_log_level_medium, "action [move] (character %s | destination %.02f)", action->key, action->parameters.destination_x);
      result = d_call(self, m_puppeteer_move_character, action->key, action->parameters.destination_x, d_false);
      break;
    case e_puppeteer_action_run:                /* key (character), destination_x */
      d_log(e_log_level_medium, "action [run] (character %s | destination %.02f)", action->key, action->parameters.destination_x);
      result = d_call(self, m_puppeteer_move_character, action->key, action->parameters.destination_x, d_true);
      break;
    case e_puppeteer_action_look:               /* key (character), entity (look at) */
      d_log(e_log_level_medium, "action [look] (character %s | entity %s)", action->key, action->parameters.entity);
      result = d_call(self, m_puppeteer_look_character, action->key, action->parameters.entity);
      break;
    case e_puppeteer_action_stare:
      d_log(e_log_level_medium, "action [stare] (character %s | entity %s)", action->key, action->parameters.entity);
      result = d_call(self, m_puppeteer_stare_character, action->key, action->parameters.entity);
    default:
      break;
  }
  return result;
}
d_define_method(puppeteer, delete)(struct s_object *self, struct s_puppeteer_attributes *attributes) {
  struct s_puppeteer_character *current_character;
  d_delete(attributes->factory);
  while ((current_character = (struct s_puppeteer_character *) ((struct s_list_node *) attributes->characters.head))) {
    f_list_delete(&(attributes->characters), (struct s_list_node *) current_character);
    if (current_character->connected)
      d_delete(current_character->connected);
    d_delete(current_character->character);
    d_free(current_character);
  }
  return NULL;
}
d_define_class(puppeteer) {d_hook_method(puppeteer, e_flag_public, get_character),
                           d_hook_method(puppeteer, e_flag_public, hide_characters),
                           d_hook_method(puppeteer, e_flag_public, show_character),
                           d_hook_method(puppeteer, e_flag_public, enable_control),
                           d_hook_method(puppeteer, e_flag_public, disable_control),
                           d_hook_method(puppeteer, e_flag_public, say_character),
                           d_hook_method(puppeteer, e_flag_public, talk_character),
                           d_hook_method(puppeteer, e_flag_public, set_character),
                           d_hook_method(puppeteer, e_flag_public, move_character),
                           d_hook_method(puppeteer, e_flag_public, look_character),
                           d_hook_method(puppeteer, e_flag_public, stare_character),
                           d_hook_method(puppeteer, e_flag_public, get_main_character),
                           d_hook_method(puppeteer, e_flag_public, update),
                           d_hook_method(puppeteer, e_flag_public, linker),
                           d_hook_method(puppeteer, e_flag_public, dispatcher),
                           d_hook_delete(puppeteer),
                           d_hook_method_tail};

