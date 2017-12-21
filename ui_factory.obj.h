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
#ifndef pomodoro_ui_factory_h
#define pomodoro_ui_factory_h
#include "miranda.h"
#include "factory.obj.h"
#define d_ui_factory_label_size 32
#define d_ui_factory_font_bucket 64
#define d_ui_factory_default_mode 0
#define d_ui_factory_default_font_size 18
#define d_ui_factory_default_font_id 0
#define d_ui_factory_default_font_style TTF_STYLE_NORMAL
#define d_ui_factory_default_level 0
typedef struct s_uiable_container { d_list_node_head;
    char label[d_ui_factory_label_size];
    double position_x, position_y;
    struct s_object *uiable;
    struct s_list childs;
} s_uiable_container;
d_declare_class(ui_factory) {
    struct s_attributes head;
    struct s_object *factory;
    struct s_object *json_configuration;
    struct s_object *checkbox_bitmap_checked, *checkbox_bitmap_unchecked, *scroll_handler, *pointer_handler;
    struct s_list childs;
} d_declare_class_tail(ui_factory);
struct s_ui_factory_attributes *p_ui_factory_alloc(struct s_object *self);
extern void p_ui_factory_container_delete(struct s_uiable_container *container);
extern struct s_object *f_ui_factory_new(struct s_object *self, struct s_object *resources_png_object, struct s_object *resources_json_object, 
        struct s_object *factory, struct s_object *environment, struct s_object *json_configuration, struct s_object *json_ui);
d_declare_method(ui_factory, load_component)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment,
        struct s_object *json_ui, struct s_uiable_container *current_container, t_json_starting_point *starting_point);
d_declare_method(ui_factory, load_uiable)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, struct s_object *uiable,
        const char *component);
d_declare_method(ui_factory, new_container)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, t_boolean floatable);
d_declare_method(ui_factory, new_list)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment);
d_declare_method(ui_factory, new_scroll)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment);
d_declare_method(ui_factory, new_image)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment);
d_declare_method(ui_factory, new_label)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, unsigned int font_id,
        unsigned int font_style, char *string_content);
d_declare_method(ui_factory, new_checkbox)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, unsigned int font_id,
        unsigned int font_style, char *string_content);
d_declare_method(ui_factory, new_button)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, unsigned int font_id,
        unsigned int font_style, char *string_content);
d_declare_method(ui_factory, new_field)(struct s_object *self, struct s_object *resources_png_object, struct s_object *environment, unsigned int font_id,
        unsigned int font_style, char *string_content);
d_declare_method(ui_factory, show_container)(struct s_object *self, struct s_object *environment, struct s_object *container);
d_declare_method(ui_factory, hide_container)(struct s_object *self, struct s_object *environment, struct s_object *container);
d_declare_method(ui_factory, get_component)(struct s_object *self, struct s_uiable_container *current_container, const char *label);
d_declare_method(ui_factory, delete)(struct s_object *self, struct s_ui_factory_attributes *attributes);
extern void f_ui_factory_callback_visibility(struct s_object *self, void **parameters, size_t entries);
#endif
