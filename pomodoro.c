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
#define d_pomodoro_title "Pomodoro"
#define d_pomodoro_resources "./data"
#define d_pomodoro_resources_default_png 	"./data/placeholders/default_png.png"
#define d_pomodoro_resources_default_ttf 	"./data/placeholders/default_ttf.ttf"
#define d_pomodoro_resources_default_json 	"./data/placeholders/default_json.json"
#define d_pomodoro_resources_default_ogg	"./data/placeholders/default_ogg.wav"
#define d_pomodoro_resources_default_lisp   "./data/placeholders/default_lisp.lisp"
struct s_object *resources_png, *resources_ttf, *resources_ogg, *resources_json, *resources_lisp;
struct s_object *factory;
struct s_object *puppeteer;
struct s_object *background;
int index_loop = 0;
t_boolean pomodoro_temporary_validator(struct s_object *self, double current_x, double current_y, double current_zoom, double *new_x, double *new_y,
        double *new_zoom) {
    if (*new_x > d_pomodoro_width) {
        *new_x = current_x;
        *new_y = current_y;
        *new_zoom = current_zoom;
        return d_false;
    }
    if (*new_x > d_pomodoro_height)
        return d_false;
    *new_y = 550.0;
    return d_true;
}

int pomodoro_load_call(struct s_object *environment) {
    struct s_exception *exception;
    struct s_object *resources_path = f_string_new_constant(d_new(string), d_pomodoro_resources),
                    *template_png   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_png),
                    *template_ttf   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ttf),
                    *template_json  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_json),
                    *template_ogg   = f_string_new_constant(d_new(string), d_pomodoro_resources_default_ogg),
                    *template_lisp  = f_string_new_constant(d_new(string), d_pomodoro_resources_default_lisp);
    struct s_object *png_stream;
    d_try {
        d_assert(resources_png = f_resources_new_template(d_new(resources), resources_path, template_png, ".png"));
        d_assert(resources_ttf = f_resources_new_template(d_new(resources), resources_path, template_ttf, ".ttf"));
        d_assert(resources_json = f_resources_new_template(d_new(resources), resources_path, template_json, ".json"));
        d_assert(resources_ogg = f_resources_new_template(d_new(resources), resources_path, template_ogg, ".wav.ogg"));
        d_assert(resources_lisp = f_resources_new_template(d_new(resources), resources_path, template_lisp, ".lisp"));
        d_assert(factory = f_factory_new(d_new(factory), resources_png, resources_ttf, resources_json, resources_ogg, resources_lisp, environment));
        d_assert(puppeteer = f_puppeteer_new(d_new(puppeteer), factory, pomodoro_temporary_validator));
        if ((png_stream = d_call(resources_png, m_resources_get_stream, "default_background", e_resources_type_common)))
            if ((background = f_bitmap_new(d_new(bitmap), png_stream, environment)))
                d_call(environment, m_environment_add_drawable, background, 0, e_environment_surface_primary);
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
    d_call(puppeteer, m_puppeteer_show_character, "luca", 200.0);
    d_call(puppeteer, m_puppeteer_show_character, "andrea", 300.0);
    d_call(puppeteer, m_puppeteer_show_character, "andrii", 600.0);
    /* test area code */
    //d_call(environment, m_environment_add_drawable, d_call(puppeteer, m_puppeteer_get_character, "luca"), 5, e_environment_surface_primary);
    /*struct s_object *code_stream = d_call(resources_lisp, m_resources_get_stream, "default_lisp", e_resources_type_common);
    struct s_object *lisp_object = f_lisp_new(d_new(lisp), code_stream, STDOUT_FILENO);
    d_call(lisp_object, m_lisp_run, NULL);
    d_delete(lisp_object);

    entity = f_character_new(d_new(character), "amedeo", NULL);
    struct s_object *base_stream, *base_json;
    if ((base_stream = d_call(resources_json, m_resources_get_stream, "luca_character", e_resources_type_common))) {
        base_json = f_json_new_stream(d_new(json), base_stream);
        d_call(entity, m_character_load, base_json, factory);
        d_call(entity, m_controllable_set, d_true);
        d_call(entity, m_drawable_set_position, (double)200.0, (double)550.0);
        d_call(environment, m_environment_add_drawable, entity, 5, e_environment_surface_primary);
        d_delete(base_json);
    }*/
    return d_true;
}

int pomodoro_loop_call(struct s_object *environment) {
    if ((++index_loop) == 100)
        d_call(puppeteer, m_puppeteer_move_character, "andrii", 1400.0);
    if (index_loop == 450)
        d_call(puppeteer, m_puppeteer_say_character, "luca", "Ma di che stamo a parla'? Secondo me qua bisogna costruire tutto!", 5);
    if (index_loop == 550)
        d_call(puppeteer, m_puppeteer_set_character, "andrii", "back_code");
    return d_true;
}

int pomodoro_quit_call(struct s_object *environment) {
    d_delete(background);
    d_delete(resources_png);
    d_delete(resources_ttf);
    d_delete(resources_json);
    d_delete(resources_ogg);
    d_delete(resources_lisp);
    d_delete(puppeteer);
    d_delete(factory);
    return d_true;
}

int main (int argc, char *argv[]) {
    struct s_exception *exception;
    struct s_object *environment;
    d_pool_init;
    v_log_level = e_log_level_medium;
    d_pool_begin("main context") {
        /* wait the unlock */
        d_try {
            environment = f_environment_new_fullscreen(d_new(environment), d_pomodoro_width, d_pomodoro_height, d_false);
            d_call(environment, m_environment_set_methods, &pomodoro_load_call, &pomodoro_loop_call, &pomodoro_quit_call);
            d_call(environment, m_environment_set_reference, d_pomodoro_width, d_pomodoro_height, e_environment_surface_primary);
            d_call(environment, m_environment_set_reference, d_pomodoro_width, d_pomodoro_height, e_environment_surface_ui);
            d_call(environment, m_environment_set_title, d_pomodoro_title);
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
