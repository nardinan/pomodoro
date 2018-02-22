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
  "arms",
  "cap",
  "eyes",
  "hair",
  "head",
  "legs",
  "body"
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
  d_call(self, m_controllable_add_configuration, SDLK_LEFT, p_character_move_left, p_character_move_left, p_character_run_left, d_true);
  d_call(self, m_controllable_add_configuration, SDLK_RIGHT, p_character_move_right, p_character_move_right, p_character_run_right, d_true);
  d_call(self, m_controllable_add_configuration, SDLK_UP, p_character_move_up, p_character_move_up, p_character_move_up, d_true);
  d_call(self, m_controllable_add_configuration, SDLK_DOWN, p_character_move_down, p_character_move_down, p_character_move_down, d_true);
  d_call(self, m_controllable_add_configuration, SDLK_SPACE, p_character_action, p_character_action, p_character_action, d_true);
  attributes->direction = e_character_direction_down;
  attributes->set = d_true;
  return self;
}
d_define_method(character, load)(struct s_object *self, struct s_object *json, struct s_object *factory) {
  d_using(character);
  struct s_character_scoped_list {
    char *key;
    enum e_uiable_components component;
  } scoped_list[] = {{"corner_top_left",     e_uiable_component_corner_top_left},
                     {"corner_top_right",    e_uiable_component_corner_top_right},
                     {"corner_bottom_left",  e_uiable_component_corner_bottom_left},
                     {"corner_bottom_right", e_uiable_component_corner_bottom_right},
                     {"left",                e_uiable_component_left},
                     {"right",               e_uiable_component_right},
                     {"top",                 e_uiable_component_top},
                     {"bottom",              e_uiable_component_bottom},
                     {"center",              e_uiable_component_center},
                     {"tail",                e_uiable_component_NULL},
                     {NULL}};
  struct s_character_scoped_color {
    double mask_R, mask_G, mask_B, mask_A;
  } scoped_colors[e_character_component_NULL];
  struct s_object *drawable;
  enum e_drawable_flips flips;
  enum e_factory_media_types type;
  char *string_supply, *string_supply_component;
  t_boolean status_flip_x, status_flip_y, character_flip_x, character_flip_y;
  double offset_x, offset_y, mask_R = 255.0, mask_G = 255.0, mask_B = 255.0, mask_A = 255.0, zoom = 1.0, speed_x, speed_y, speed_z;
  int index_status = 0, index_component, index;
  character_attributes->collidable = d_true;
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
        d_assert(character_attributes->bubble =
                   f_bubble_new(d_new(bubble), factory, (unsigned int) mask_R, (unsigned int) mask_G, (unsigned int) mask_B, (unsigned int) mask_A,
                                TTF_STYLE_NORMAL));
        for (index = 0; scoped_list[index].key; ++index)
          if ((d_call(json, m_json_get_string, &string_supply, "ss", "bubble", scoped_list[index].key)))
            if ((drawable = d_call(factory, m_factory_get_media, string_supply, &type))) {
              d_call(character_attributes->bubble, m_bubble_set, drawable, scoped_list[index].component);
              d_delete(drawable);
            }
        d_call(json, m_json_get_boolean, &(character_attributes->collidable), "s", "collidable");
        d_call(json, m_json_get_double, &zoom, "s", "zoom");
        for (index_component = 0; index_component < e_character_component_NULL; ++index_component) {
          scoped_colors[index_component].mask_R = 255.0;
          scoped_colors[index_component].mask_G = 255.0;
          scoped_colors[index_component].mask_B = 255.0;
          scoped_colors[index_component].mask_A = 255.0;
          d_call(json, m_json_get_double, &(scoped_colors[index_component].mask_R), "sss", "colors", v_character_components_label[index_component], "mask_R");
          d_call(json, m_json_get_double, &(scoped_colors[index_component].mask_G), "sss", "colors", v_character_components_label[index_component], "mask_G");
          d_call(json, m_json_get_double, &(scoped_colors[index_component].mask_B), "sss", "colors", v_character_components_label[index_component], "mask_B");
          d_call(json, m_json_get_double, &(scoped_colors[index_component].mask_A), "sss", "colors", v_character_components_label[index_component], "mask_A");
        }
        while (d_call(json, m_json_get_string, &string_supply_component, "sds", "statuses", index_status, "label")) {
          speed_x = 0;
          speed_y = 0;
          speed_z = 0;
          offset_x = 0;
          offset_y = 0;
          status_flip_x = d_false;
          status_flip_y = d_false;
          d_call(json, m_json_get_double, &speed_x, "sds", "statuses", index_status, "speed_x");
          d_call(json, m_json_get_double, &speed_y, "sds", "statuses", index_status, "speed_y");
          d_call(json, m_json_get_double, &speed_z, "sds", "statuses", index_status, "speed_z");
          d_call(json, m_json_get_double, &offset_x, "sds", "statuses", index_status, "offset_x");
          d_call(json, m_json_get_double, &offset_y, "sds", "statuses", index_status, "offset_y");
          d_call(json, m_json_get_boolean, &status_flip_y, "sds", "statuses", index_status, "flip_y");
          d_call(json, m_json_get_boolean, &status_flip_x, "sds", "statuses", index_status, "flip_x");
          d_call(self, m_entity_add_component, string_supply_component, speed_x, speed_y, speed_z, offset_x, offset_y);
          for (index_component = 0; index_component < e_character_component_NULL; ++index_component) {
            offset_x = 0;
            offset_y = 0;
            character_flip_x = status_flip_x;
            character_flip_y = status_flip_y;
            mask_R = scoped_colors[index_component].mask_R;
            mask_G = scoped_colors[index_component].mask_G;
            mask_B = scoped_colors[index_component].mask_B;
            mask_A = scoped_colors[index_component].mask_A;
            if ((d_call(json, m_json_get_string, &string_supply, "sdss", "statuses", index_status, v_character_components_label[index_component],
                        "drawable"))) {
              d_call(json, m_json_get_double, &offset_x, "sdss", "statuses", index_status, v_character_components_label[index_component], "offset_x");
              d_call(json, m_json_get_double, &offset_y, "sdss", "statuses", index_status, v_character_components_label[index_component], "offset_y");
              d_call(json, m_json_get_boolean, &character_flip_x, "sdss", "statuses", index_status, v_character_components_label[index_component], "flip_x");
              d_call(json, m_json_get_boolean, &character_flip_y, "sdss", "statuses", index_status, v_character_components_label[index_component], "flip_y");
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
                d_call(self, m_entity_add_element, string_supply_component, offset_x, offset_y, drawable);
                d_call(drawable, m_drawable_set_maskRGB, (unsigned int) mask_R, (unsigned int) mask_G, (unsigned int) mask_B);
                d_call(drawable, m_drawable_set_maskA, (unsigned int) mask_A);
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
    d_foreach(&(entity_attributes->current_component->elements), current_element, struct s_entity_element)if ((animation_attributes =
                                                                                                                 d_cast(current_element->drawable,
                                                                                                                        animation))) {
        d_call(current_element->drawable, m_animation_set_status, e_animation_direction_stop);
        d_call(current_element->drawable, m_animation_set_status, e_animation_direction_forward);
      }
  return result;
}
d_define_method(character, move_left)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  if (pressed) {
    d_call(self, m_entity_set_component, "walk_left");
    character_attributes->movement = d_true;
    character_attributes->running = d_false;
    character_attributes->sliding = d_false;
  } else if ((character_attributes->movement) || (character_attributes->direction != e_character_direction_left)) {
    if (character_attributes->running) {
      d_call(self, m_entity_set_component, "walk_left");
      gettimeofday(&(character_attributes->last_stop), NULL);
      character_attributes->sliding = d_true;
      character_attributes->running = d_false;
    } else {
      d_call(self, m_entity_set_component, "still_left");
      character_attributes->movement = d_false;
    }
  }
  character_attributes->direction = e_character_direction_left;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, run_left)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  if (pressed) {
    d_call(self, m_entity_set_component, "run_left");
    character_attributes->movement = d_true;
    character_attributes->running = d_true;
    character_attributes->sliding = d_false;
  } else if ((character_attributes->movement) || (character_attributes->direction != e_character_direction_left)) {
    d_call(self, m_entity_set_component, "walk_left");
    gettimeofday(&(character_attributes->last_stop), NULL);
    character_attributes->sliding = d_true;
    character_attributes->running = d_false;
  }
  character_attributes->direction = e_character_direction_left;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, move_right)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  if (pressed) {
    d_call(self, m_entity_set_component, "walk_right");
    character_attributes->movement = d_true;
    character_attributes->running = d_false;
    character_attributes->sliding = d_false;
  } else if ((character_attributes->movement) || (character_attributes->direction != e_character_direction_right)) {
    if (character_attributes->running) {
      d_call(self, m_entity_set_component, "walk_right");
      gettimeofday(&(character_attributes->last_stop), NULL);
      character_attributes->sliding = d_true;
      character_attributes->running = d_false;
    } else {
      d_call(self, m_entity_set_component, "still_right");
      character_attributes->movement = d_false;
    }
  }
  character_attributes->direction = e_character_direction_right;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, run_right)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  if (pressed) {
    d_call(self, m_entity_set_component, "run_right");
    character_attributes->movement = d_true;
    character_attributes->running = d_true;
    character_attributes->sliding = d_false;
  } else if ((character_attributes->movement) || (character_attributes->direction != e_character_direction_right)) {
    d_call(self, m_entity_set_component, "walk_right");
    gettimeofday(&(character_attributes->last_stop), NULL);
    character_attributes->sliding = d_true;
    character_attributes->running = d_false;
  }
  character_attributes->direction = e_character_direction_right;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, move_up)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  d_call(self, m_entity_set_component, "back");
  character_attributes->movement = d_false;
  character_attributes->running = d_false;
  character_attributes->sliding = d_false;
  character_attributes->direction = e_character_direction_up;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, move_down)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  d_call(self, m_entity_set_component, "front");
  character_attributes->movement = d_false;
  character_attributes->running = d_false;
  character_attributes->sliding = d_false;
  character_attributes->direction = e_character_direction_down;
  character_attributes->set = d_true;
  return self;
}
d_define_method(character, move_clean)(struct s_object *self, t_boolean expire_direction) {
  d_using(character);
  character_attributes->movement = d_false;
  character_attributes->sliding = d_false;
  character_attributes->running = d_false;
  character_attributes->set = d_true;
  if (expire_direction)
    character_attributes->direction = e_character_direction_unknown;
  return self;
}
d_define_method(character, action)(struct s_object *self, struct s_controllable_entry *entry, t_boolean pressed) {
  d_using(character);
  if (!pressed)
    character_attributes->action = d_true;
  return self;
}
d_define_method(character, say)(struct s_object *self, const char *message, time_t timeout) {
  d_using(character);
  if (character_attributes->bubble)
    d_call(character_attributes->bubble, m_bubble_add_message, message, timeout, d_character_default_font);
  return self;
}
d_define_method(character, talk)(struct s_object *self, const char *message, struct s_object *track) {
  d_using(character);
  if (character_attributes->bubble)
    d_call(character_attributes->bubble, m_bubble_add_track, message, track, d_character_default_font);
  return self;
}
d_define_method(character, move)(struct s_object *self, double destination_x, t_boolean run) {
  d_using(character);
  double position_x, position_y;
  d_call(self, m_drawable_get_position, &position_x, &position_y);
  character_attributes->destination_x = destination_x;
  character_attributes->source_x = position_x;
  if (destination_x != position_x)
    d_call(self,
           ((destination_x > position_x) ? ((run) ? m_character_run_right : m_character_move_right) : ((run) ? m_character_run_left : m_character_move_left)),
           NULL, d_true);
  return self;
}
d_define_method(character, is_speaking)(struct s_object *self) {
  d_using(character);
  struct s_bubble_attributes *bubble_attributes;
  t_boolean result = d_false;
  if (character_attributes->bubble) {
    bubble_attributes = d_cast(character_attributes->bubble, bubble);
    if ((bubble_attributes->current_element) || (bubble_attributes->messages.fill > 0))
      result = d_true;
  }
  d_cast_return(result);
}
d_define_method(character, is_moving)(struct s_object *self) {
  struct s_entity_attributes *entity_attributes = d_cast(self, entity);
  t_boolean result = d_false;
  if ((entity_attributes->current_component) &&
      ((fabs(entity_attributes->current_component->speed_x) > 0.0) || (fabs(entity_attributes->current_component->speed_y) > 0.0) ||
       (fabs(entity_attributes->current_component->speed_z) > 0.0)))
    result = d_true;
  d_cast_return(result);
}
d_define_method(character, show_bubble)(struct s_object *self, struct s_object *environment) {
  d_using(character);
  if (character_attributes->bubble)
    d_call(environment, m_environment_add_drawable, character_attributes->bubble, d_bubble_default_layer, e_environment_surface_primary);
  return self;
}
d_define_method(character, hide_bubble)(struct s_object *self, struct s_object *environment) {
  d_using(character);
  if (character_attributes->bubble)
    d_call(environment, m_environment_del_drawable, character_attributes->bubble, d_bubble_default_layer, e_environment_surface_primary);
  return self;
}
d_define_method_override(character, draw)(struct s_object *self, struct s_object *environment) {
  d_using(character);
  struct s_environment_attributes *environment_attributes = d_cast(environment, environment);
  struct s_bubble_attributes *bubble_attributes;
  struct s_drawable_attributes *drawable_attributes_self = d_cast(self, drawable), *drawable_attributes_bubble;
  struct timeval current, elapsed_update;
  double position_x, position_y, bubble_position_x, bubble_position_y, ratio_x, total_zoom, principal_point_x, principal_point_y, real_elapsed_update;
  struct s_object *result = d_call_owner(self, entity, m_drawable_draw, environment); /* recall the father's draw method */
  d_call(self, m_drawable_get_position, &position_x, &position_y);
  if (((character_attributes->source_x < character_attributes->destination_x) && (position_x >= character_attributes->destination_x)) ||
      ((character_attributes->source_x > character_attributes->destination_x) && (position_x <= character_attributes->destination_x))) {
    d_call(self, (character_attributes->destination_x > character_attributes->source_x) ? m_character_move_right : m_character_move_left, NULL, d_false);
    character_attributes->source_x = character_attributes->destination_x;
  }
  if (character_attributes->bubble) {
    bubble_attributes = d_cast(character_attributes->bubble, bubble);
    drawable_attributes_bubble = d_cast(character_attributes->bubble, drawable);
    ratio_x = (environment_attributes->current_w / environment_attributes->reference_w[environment_attributes->current_surface]);
    total_zoom = drawable_attributes_self->zoom;
    bubble_position_x = position_x + (character_attributes->bubble_offset_x * total_zoom);
    bubble_position_y = position_y + (character_attributes->bubble_offset_y * total_zoom) - bubble_attributes->total_height;
    if (((bubble_position_x * ratio_x) + bubble_attributes->maximum_width * ratio_x -
         environment_attributes->camera_origin_x[environment_attributes->current_surface]) > environment_attributes->current_w) {
      bubble_attributes->current_position = e_bubble_position_left;
      bubble_position_x -= bubble_attributes->maximum_width;
    } else
      bubble_attributes->current_position = e_bubble_position_right;
    d_call(character_attributes->bubble, m_drawable_set_position, bubble_position_x, bubble_position_y);
    drawable_attributes_bubble->angle = drawable_attributes_self->angle;
    drawable_attributes_bubble->zoom = drawable_attributes_self->zoom;
    drawable_attributes_bubble->flip = drawable_attributes_self->flip;
  }
  if (character_attributes->sliding) {
    gettimeofday(&current, NULL);
    timersub(&current, &(character_attributes->last_stop), &elapsed_update);
    if ((real_elapsed_update = elapsed_update.tv_sec + ((double) (elapsed_update.tv_usec) / 1000000.0)) > d_character_default_sliding_time) {
      if (character_attributes->direction == e_character_direction_left)
        d_call(self, m_entity_set_component, "still_left");
      else
        d_call(self, m_entity_set_component, "still_right");
      character_attributes->sliding = d_false;
      character_attributes->movement = d_false;
    }
  }
  if (v_developer_mode) {
    d_call(self, m_drawable_get_scaled_principal_point, &principal_point_x, &principal_point_y);
    f_primitive_fill_triangle(environment_attributes->renderer, (principal_point_x - d_character_principal_point_offset),
                              (principal_point_y + d_character_principal_point_offset), (principal_point_x + d_character_principal_point_offset),
                              (principal_point_y + d_character_principal_point_offset), principal_point_x,
                              (principal_point_y - d_character_principal_point_offset), d_character_principal_point_red, d_character_principal_point_green,
                              d_character_principal_point_blue, d_character_principal_point_alpha);
  }
  return result;
}
d_define_method(character, delete)(struct s_object *self, struct s_character_attributes *attributes) {
  if (attributes->bubble)
    d_delete(attributes->bubble);
  return NULL;
}
d_define_class(character) {d_hook_method(character, e_flag_public, load),
                           d_hook_method_override(character, e_flag_public, entity, set_component),
                           d_hook_method(character, e_flag_public, move_left),
                           d_hook_method(character, e_flag_public, run_left),
                           d_hook_method(character, e_flag_public, move_right),
                           d_hook_method(character, e_flag_public, run_right),
                           d_hook_method(character, e_flag_public, move_up),
                           d_hook_method(character, e_flag_public, move_down),
                           d_hook_method(character, e_flag_public, move_clean),
                           d_hook_method(character, e_flag_public, action),
                           d_hook_method(character, e_flag_public, say),
                           d_hook_method(character, e_flag_public, talk),
                           d_hook_method(character, e_flag_public, move),
                           d_hook_method(character, e_flag_public, is_speaking),
                           d_hook_method(character, e_flag_public, is_moving),
                           d_hook_method(character, e_flag_public, show_bubble),
                           d_hook_method(character, e_flag_public, hide_bubble),
                           d_hook_method_override(character, e_flag_public, drawable, draw),
                           d_hook_delete(character),
                           d_hook_method_tail};
