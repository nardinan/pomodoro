/*
 * pomodoro
 * Copyright (C) 2017 Andrea Nardinocchi (andrea@nardinan.it)
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
#include "loader.obj.h"
struct s_loader_attributes *p_loader_alloc(struct s_object *self) {
  struct s_loader_attributes *result = d_prepare(self, loader);
  f_memory_new(self);     /* inherit */
  f_mutex_new(self);      /* inherit */
  f_runnable_new(self);   /* inherit */
  return result;
}
struct s_object *f_loader_new(struct s_object *self, struct s_object *environment) {
  struct s_loader_attributes *attributes = p_loader_alloc(self);
  attributes->environment = d_retain(environment);
  attributes = attributes;
  return self;
}
d_define_method_override(loader, job)(struct s_object *self) {
  d_using(loader);
  struct s_exception *exception;
  struct s_object *stream_configuration, *stream_ui;
  struct s_object *json_configuration, *json_ui;
  struct s_object *resources_path = f_string_new_constant(d_new(string), d_pomodoro_resources),
    *template_png = f_string_new_constant(d_new(string), d_pomodoro_resources_default_png),
    *template_ttf = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ttf),
    *template_json = f_string_new_constant(d_new(string), d_pomodoro_resources_default_json),
    *template_ogg = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ogg),
    *template_lisp = f_string_new_constant(d_new(string), d_pomodoro_resources_default_lisp);
  d_try{
        d_assert(loader_attributes->resources_png = f_resources_new_template(d_new(resources), resources_path, template_png, ".png"));
        d_assert(loader_attributes->resources_ttf = f_resources_new_template(d_new(resources), resources_path, template_ttf, ".ttf"));
        d_assert(loader_attributes->resources_json = f_resources_new_template(d_new(resources), resources_path, template_json, ".json"));
        d_assert(loader_attributes->resources_ogg = f_resources_new_template(d_new(resources), resources_path, template_ogg, ".wav.ogg"));
        d_assert(loader_attributes->resources_lisp = f_resources_new_template(d_new(resources), resources_path, template_lisp, ".lisp"));
        if ((loader_attributes->factory =
               f_factory_new(d_new(factory), loader_attributes->resources_png, loader_attributes->resources_ttf, loader_attributes->resources_json,
                             loader_attributes->resources_ogg, loader_attributes->resources_lisp, loader_attributes->environment))) {
          if ((loader_attributes->director = f_director_new(d_new(director), loader_attributes->factory))) {
            director = loader_attributes->director;
            d_assert(
              stream_configuration = d_call(loader_attributes->resources_json, m_resources_get_stream, d_factory_configuration, e_resources_type_common));
            if ((json_configuration = f_json_new_stream(d_new(json), stream_configuration))) {
              d_assert(stream_ui = d_call(loader_attributes->resources_json, m_resources_get_stream, d_factory_ui, e_resources_type_common));
              if ((json_ui = f_json_new_stream(d_new(json), stream_ui))) {
                loader_attributes->ui_factory =
                  f_ui_factory_new(d_new(ui_factory), loader_attributes->resources_png, loader_attributes->resources_ttf, loader_attributes->resources_json,
                                   loader_attributes->environment, json_configuration, json_ui);
                d_delete(json_ui);
              }
              d_delete(json_configuration);
            }
          } else
            d_die(d_error_malloc);
        } else
          d_die(d_error_malloc);
        d_delete(template_lisp);
        d_delete(template_ogg);
        d_delete(template_json);
        d_delete(template_ttf);
        d_delete(template_png);
        d_delete(resources_path);
      }d_catch(exception)
      {
        d_exception_dump(stderr, exception);
        d_raise;
      }d_endtry;
  return self;
}
d_define_method(loader, delete)(struct s_object *self, struct s_loader_attributes *attributes) {
  d_delete(attributes->resources_png);
  d_delete(attributes->resources_ttf);
  d_delete(attributes->resources_json);
  d_delete(attributes->resources_ogg);
  d_delete(attributes->resources_lisp);
  d_delete(attributes->director);
  d_delete(attributes->ui_factory);
  d_delete(attributes->factory);
  d_delete(attributes->environment);
  return self;
}
d_define_class(loader) {d_hook_method_override(loader, e_flag_public, runnable, job),
                        d_hook_delete(loader),
                        d_hook_method_tail};
