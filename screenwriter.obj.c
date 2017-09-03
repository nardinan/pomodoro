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
#include "screenwriter.obj.h"
#include "puppeteer.obj.h"
#include "collector.obj.h"
const char *v_screenwriter_types[] = {
    "dialog",
    "choice",
    "set"
};

int p_screenwriter_get_dialog(struct s_object *json, const char *ID) {
    int result = d_screenwriter_not_found, index = 0;
    char *current_ID;
    while (d_call(json, m_json_get_string, &current_ID, "sds", "dialogs", index, "ID")) {
        if (f_string_strcmp(current_ID, ID) == 0) {
            result = index;
            break;
        }
        ++index;
    }
    return result;
}

struct s_screenwriter_attributes *p_screenwriter_alloc(struct s_object *self) {
    struct s_screenwriter_attributes *result = d_prepare(self, screenwriter);
    f_memory_new(self); /* inherit */
    f_mutex_new(self);  /* inherit */
    return result;
}

struct s_object *f_screenwriter_new(struct s_object *self, struct s_object *factory, struct s_object *puppeteer, struct s_object *collector) {
    struct s_screenwriter_attributes *attributes = p_screenwriter_alloc(self);
    attributes->factory = d_retain(factory);
    attributes->puppeteer = d_retain(puppeteer);
    attributes->collector = d_retain(collector);
    return self;
}

d_define_method(screenwriter, set_language)(struct s_object *self, enum e_screenwriter_languages language) {
    d_using(screenwriter);
    screenwriter_attributes->language = language;
    d_call(screenwriter_attributes->collector, m_collector_add_entry_double, "language", (double)(screenwriter_attributes->language));
    return self;
}

d_define_method(screenwriter, load)(struct s_object *self, struct s_object *json) {
    d_using(screenwriter);
    char *string_supply, *dialog_ID, *next_entry_ID, *current_type, *current_actor, *current_key;
    int index_dialog = 0, index_next_entry, index_next_assignment, index_language, index_option, option_ID;
    double delay;
    struct s_screenwriter_entry *current_entry;
    struct s_screenwriter_option *current_option;
    struct s_screenwriter_set *current_set;
    if (d_call(json, m_json_get_string, &string_supply, "s", "format"))
        if (f_string_strcmp(string_supply, "dialog") == 0)
            while ((d_call(json, m_json_get_string, &dialog_ID, "sds", "dialogs", index_dialog, "ID")) &&
                    (d_call(json, m_json_get_string, &current_type, "sds", "dialogs", index_dialog, "type"))) {
                if (f_string_strcmp(current_type, v_screenwriter_types[e_screenwriter_type_dialog]) == 0) {
                    if ((current_entry = (struct s_screenwriter_entry *)d_malloc(sizeof(struct s_screenwriter_entry)))) {
                        strncpy(current_entry->ID, dialog_ID, d_string_buffer_size);
                        if ((d_call(json, m_json_get_string, &next_entry_ID, "sds", "dialogs", index_dialog, "next")) && (next_entry_ID))
                            strncpy(current_entry->next_ID, next_entry_ID, d_string_buffer_size);
                        if (d_call(json, m_json_get_string, &current_actor, "sds", "dialogs", index_dialog, "actor"))
                            strncpy(current_entry->actor, current_actor, d_entity_label_size);
                        if (d_call(json, m_json_get_double, &delay, "sds", "dialogs", index_dialog, "delay"))
                            current_entry->delay = delay;
                        index_language = 0;
                        while ((index_language < e_screenwriter_language_NULL) && 
                                (d_call(json, m_json_get_string, &string_supply, "sdsd", "dialogs", index_dialog, "content", index_language))) {
                            if (string_supply) 
                                strncpy(current_entry->content[index_language], string_supply, d_bubble_message_size);
                            ++index_language;
                        }
                        index_option = 0;
                        option_ID = 0;
                        while ((d_call(json, m_json_get_string, &next_entry_ID, "sdsd", "dialogs", index_dialog, "choices", index_option))) {
                            if (((index_next_entry = p_screenwriter_get_dialog(json, next_entry_ID)) != d_screenwriter_not_found) &&
                                    (d_call(json, m_json_get_string, &current_type, "sds", "dialogs", index_next_entry, "type"))) {
                                if (f_string_strcmp(current_type, v_screenwriter_types[e_screenwriter_type_choice]) == 0) {
                                    if ((current_option = (struct s_screenwriter_option *)d_malloc(sizeof(struct s_screenwriter_option)))) {
                                        current_option->ID = option_ID++;
                                        index_language = 0;
                                        while ((index_language < e_screenwriter_language_NULL) &&
                                                (d_call(json, m_json_get_string, &string_supply, "sdsd", "dialogs", index_next_entry, "content", index_language))) {
                                            if (string_supply)
                                                strncpy(current_option->content[index_language], string_supply, d_bubble_message_size);
                                            ++index_language;
                                        }
                                        if ((d_call(json, m_json_get_string, &next_entry_ID, "sds", "dialogs", index_next_entry, "next")) && (next_entry_ID)) {
                                            while (((index_next_assignment = p_screenwriter_get_dialog(json, next_entry_ID)) != d_screenwriter_not_found) &&
                                                    (d_call(json, m_json_get_string, &current_type, "sds", "dialogs", index_next_assignment, "type")))
                                                if (f_string_strcmp(current_type, v_screenwriter_types[e_screenwriter_type_set]) == 0) {
                                                    if ((current_set = (struct s_screenwriter_set *) d_malloc(sizeof(struct s_screenwriter_set)))) {
                                                        if (d_call(json, m_json_get_string, &current_key, "sds", "dialogs", index_next_assignment, "variable"))
                                                            strncpy(current_set->key, current_key, d_lisp_symbol_size);
                                                        d_call(json, m_json_get_double, &(current_set->value), "sds", "dialogs", index_next_assignment, "value");
                                                        f_list_append(&(current_option->values), (struct s_list_node *)current_set, e_list_insert_tail);
                                                        if ((!d_call(json, m_json_get_string, &next_entry_ID, "sds", "dialogs", index_next_assignment, "next")) ||
                                                                (!next_entry_ID)) {
                                                            d_err(e_log_level_ever, "missing 'next' filed in dialog[%d], dialog could be compromised", 
                                                                    index_next_assignment);
                                                            break;
                                                        }
                                                    } else
                                                        d_die(d_error_malloc);
                                                } else
                                                    break;
                                            strncpy(current_option->next_ID, next_entry_ID, d_string_buffer_size);
                                        } else
                                            d_err(e_log_level_ever, "missing 'next' field in dialog[%d], dialog could be compromised", index_next_entry);
                                        f_list_append(&(current_entry->options), (struct s_list_node *)current_option, e_list_insert_tail);
                                    } else
                                        d_die(d_error_malloc);
                                }
                            }
                            ++index_option;
                        }
                        f_list_append(&(screenwriter_attributes->dialogs), (struct s_list_node *)current_entry, e_list_insert_tail);
                    } else
                        d_die(d_error_malloc);
                }
                ++index_dialog;
            }
    return self;
}

d_define_method(screenwriter, run)(struct s_object *self, const char *label) {
    d_using(screenwriter);
    struct s_object *json;
    struct s_screenwriter_entry *current_entry;
    struct s_screenwriter_option *current_option;
    struct s_screenwriter_set *current_set;
    screenwriter_attributes->started = d_false;
    screenwriter_attributes->completed = d_false;
    while ((current_entry = (struct s_screenwriter_entry *)screenwriter_attributes->dialogs.head)) {
        f_list_delete(&(screenwriter_attributes->dialogs), (struct s_list_node *)current_entry);
        while ((current_option = (struct s_screenwriter_option *)current_entry->options.head)) {
            f_list_delete(&(current_entry->options), (struct s_list_node *)current_option);
            while ((current_set = (struct s_screenwriter_set *)current_option->values.head)) {
                f_list_delete(&(current_option->values), (struct s_list_node *)current_set);
                d_free(current_set);
            }
            d_free(current_option);
        }
        d_free(current_entry);
    }
    if ((json = d_call(screenwriter_attributes->factory, m_factory_get_json, label))) {
        d_call(self, m_screenwriter_load, json);
        d_delete(json);
    }
    return self;
}

d_define_method(screenwriter, get)(struct s_object *self, const char *ID) {
    d_using(screenwriter);
    struct s_screenwriter_entry *current_entry = NULL;
    d_foreach(&(screenwriter_attributes->dialogs), current_entry, struct s_screenwriter_entry)
        if (f_string_strcmp(current_entry->ID, ID) == 0)
            break;
    d_cast_return(current_entry);
}

d_define_method(screenwriter, update)(struct s_object *self) {
    d_using(screenwriter);
    struct s_bubble_attributes *bubble_attributes;
    struct s_character_attributes *character_attributes;
    struct s_object *current_character;
    struct s_screenwriter_entry *next_choice = NULL;
    struct s_screenwriter_option *current_option;
    struct s_screenwriter_set *current_set;
    if (screenwriter_attributes->current_entry) {
        if ((current_character = d_call(screenwriter_attributes->puppeteer, m_puppeteer_get_character, screenwriter_attributes->current_entry->actor))) {
            if (!(intptr_t)d_call(current_character, m_character_is_speaking, NULL)) {
                if (screenwriter_attributes->current_entry->options.fill > 0) {
                    character_attributes = d_cast(current_character, character);
                    bubble_attributes = d_cast(character_attributes->bubble, bubble);
                    if (bubble_attributes->last_value != d_bubble_no_value)
                        d_foreach(&(screenwriter_attributes->current_entry->options), current_option, struct s_screenwriter_option)
                            if (bubble_attributes->last_value == current_option->ID) {
                                d_foreach(&(current_option->values), current_set, struct s_screenwriter_set)
                                    d_call(screenwriter_attributes->collector, m_collector_add_entry_double, current_set->key, current_set->value);
                                if (f_string_strlen(current_option->next_ID) > 0)
                                    next_choice = d_call(self, m_screenwriter_get, current_option->next_ID);
                            }
                } else if (f_string_strlen(screenwriter_attributes->current_entry->next_ID) > 0)
                    next_choice = d_call(self, m_screenwriter_get, screenwriter_attributes->current_entry->next_ID);
                screenwriter_attributes->current_entry = NULL;
            }
        }
    } else if (!screenwriter_attributes->started) {
        next_choice = (struct s_screenwriter_entry *)screenwriter_attributes->dialogs.head;
        screenwriter_attributes->started = d_true;
    } else
        screenwriter_attributes->completed = d_true;
    if ((!screenwriter_attributes->current_entry) && (next_choice)) {
        screenwriter_attributes->current_entry = next_choice;
        if ((current_character = d_call(screenwriter_attributes->puppeteer, m_puppeteer_get_character, screenwriter_attributes->current_entry->actor))) {
            character_attributes = d_cast(current_character, character);
            d_call(character_attributes->bubble, m_bubble_add_message, screenwriter_attributes->current_entry->content[screenwriter_attributes->language],
                    screenwriter_attributes->current_entry->delay, d_character_default_font);
            d_foreach(&(screenwriter_attributes->current_entry->options), current_option, struct s_screenwriter_option)
                d_call(character_attributes->bubble, m_bubble_add_option, current_option->content[screenwriter_attributes->language], current_option->ID);
        }
    }
    return self;
}

d_define_method(screenwriter, delete)(struct s_object *self, struct s_screenwriter_attributes *attributes) {
    struct s_screenwriter_entry *current_entry;
    struct s_screenwriter_option *current_option;
    struct s_screenwriter_set *current_set;
    d_delete(attributes->factory);
    d_delete(attributes->puppeteer);
    d_delete(attributes->collector);
    while ((current_entry = (struct s_screenwriter_entry *)attributes->dialogs.head)) {
        f_list_delete(&(attributes->dialogs), (struct s_list_node *)current_entry);
        while ((current_option = (struct s_screenwriter_option *)current_entry->options.head)) {
            f_list_delete(&(current_entry->options), (struct s_list_node *)current_option);
            while ((current_set = (struct s_screenwriter_set *)current_option->values.head)) {
                f_list_delete(&(current_option->values), (struct s_list_node *)current_set);
                d_free(current_set);
            }
            d_free(current_option);
        }
        d_free(current_entry);
    }
    return NULL;
}

d_define_class(screenwriter) {
    d_hook_method(screenwriter, e_flag_public, set_language),
        d_hook_method(screenwriter, e_flag_private, load),
        d_hook_method(screenwriter, e_flag_public, run),
        d_hook_method(screenwriter, e_flag_public, get),
        d_hook_method(screenwriter, e_flag_public, update),
        d_hook_delete(screenwriter),
        d_hook_method_tail
};
