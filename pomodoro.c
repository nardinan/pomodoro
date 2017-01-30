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
#define d_pomodoro_title "Pomodoro"
#define d_pomodoro_resources "./data"
#define d_pomodoro_resources_default_png 	"./data/placeholders/default_png.png"
#define d_pomodoro_resources_default_ttf 	"./data/placeholders/default_ttf.ttf"
#define d_pomodoro_resources_default_json 	"./data/placeholders/default_json.json"
#define d_pomodoro_resources_default_ogg	"./data/placeholders/default_ogg.wav"
#define d_pomodoro_resources_default_lisp   "./data/placeholders/default_lisp.lisp"
struct s_object *resources_png, *resources_ttf, *resources_ogg, *resources_json, *resources_lisp;
struct s_object *factory;
unsigned int current_loop = 0;
t_boolean v_developer_mode = d_false;
int pomodoro_load_call(struct s_object *environment) {
    struct s_exception *exception;
    struct s_object *resources_path = f_string_new_constant(d_new(string), d_pomodoro_resources),
                    *template_png   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_png),
                    *template_ttf   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ttf),
                    *template_json  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_json),
                    *template_ogg   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ogg),
                    *template_lisp  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_lisp);
    d_try {
        d_assert(resources_png = f_resources_new_template(d_new(resources), resources_path, template_png, ".png"));
        d_assert(resources_ttf = f_resources_new_template(d_new(resources), resources_path, template_ttf, ".ttf"));
        d_assert(resources_json = f_resources_new_template(d_new(resources), resources_path, template_json, ".json"));
        d_assert(resources_ogg = f_resources_new_template(d_new(resources), resources_path, template_ogg, ".wav.ogg"));
        d_assert(resources_lisp = f_resources_new_template(d_new(resources), resources_path, template_lisp, ".lisp"));
        d_assert(factory = f_factory_new(d_new(factory), resources_png, resources_ttf, resources_json, resources_ogg, resources_lisp, environment));
        d_assert(director = f_director_new(d_new(director), factory));
        d_call(director, m_director_run_script, "initialize_script");
        d_delete(template_png);
        d_delete(template_ttf);
        d_delete(template_json);
        d_delete(template_ogg);
        d_delete(template_lisp);
        d_delete(resources_path);
    } d_catch(exception) {
        d_exception_dump(stderr, exception);
        d_raise;
    } d_endtry;
    return d_true;
}

int pomodoro_loop_call(struct s_object *environment) {
    d_call(director, m_director_update, NULL);
    return d_true;
}

int pomodoro_quit_call(struct s_object *environment) {
    d_delete(resources_png);
    d_delete(resources_ttf);
    d_delete(resources_json);
    d_delete(resources_ogg);
    d_delete(resources_lisp);
    d_delete(director);
    d_delete(factory);
    return d_true;
}

int main (int argc, char *argv[]) {
    struct s_exception *exception;
    struct s_object *environment;
    double final_resolution_x, final_resolution_y;
    t_boolean fullscreen = d_false;
    d_pool_init;
    v_log_level = e_log_level_ever;
    if ((argc > 1) && (f_string_strcmp(argv[1], "-developer") == 0)) {
        v_log_level = e_log_level_medium;
        d_war(e_log_level_ever, "developer mode has been enabled");
        v_developer_mode = d_true;
    }
    if ((argc > 1) && (f_string_strcmp(argv[1], "-fullscreen") == 0)) {
        d_war(e_log_level_ever, "fullscreen mode has been enabled");
        fullscreen = d_true;
    }
    d_pool_begin("main context") {
        /* wait the unlock */
        d_try {
            final_resolution_x = d_pomodoro_width;
            final_resolution_y = d_pomodoro_height;
            if (v_developer_mode) {
                final_resolution_x = d_pomodoro_developer_width;
                final_resolution_y = d_pomodoro_developer_height;
            }
            environment = f_environment_new_fullscreen(d_new(environment), final_resolution_x, final_resolution_y, fullscreen);
            d_call(environment, m_environment_set_methods, &pomodoro_load_call, &pomodoro_loop_call, &pomodoro_quit_call);
            d_call(environment, m_environment_set_reference, d_pomodoro_developer_width, d_pomodoro_developer_height, e_environment_surface_primary);
            d_call(environment, m_environment_set_reference, d_pomodoro_developer_width, d_pomodoro_developer_height, e_environment_surface_ui);
            d_call(environment, m_environment_set_title, d_pomodoro_title);
            d_call(environment, m_environment_set_channels, d_factory_max_channels);
            d_call(environment, m_environment_run_loop, NULL);
            d_delete(environment);
        } d_catch(exception) {
            d_exception_dump(stderr, exception);
        } d_endtry;
    } d_pool_end;
    d_pool_destroy;
    f_memory_destroy();
    return 0;
}
