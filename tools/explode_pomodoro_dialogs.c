/* explode a CSV file and generates the skeleton of the script following the specifications */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#define d_string_buffer 255
#define d_string_max_line 4096
#define d_preview_size 32
typedef char t_boolean;
#define d_true 1
#define d_false 0
#define d_char_tab "  "
const char *output_header[] = {
  ";Pomodoro - I have no money and I must eat an ice cream\n",
  ";this script has been generated automatically and then has been polished manually\n",
  ";(sounds professional, uh? Well, it is not)\n",
  NULL
};
const char *output_functions[] = {
  ";High level functions\n",
  ";@brief: say <character> <message>\n",
  ";@description: character <character> says <message> and the system waits for the bubble to disappear\n",
  "(define say\n",
  "  (lambda (c m)\n",
  "    (begin\n",
  "      (puppeteer_say c m (+ 1 (* (length m) 0.05)))\n",
  "      (director_wait_message c)\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  ";@brief: talk <character> <message> <track>\n",
  ";@description: similar to 'say', but is it possible to associate an audio track to the dialog\n",
  "(define talk\n",
  "  (lambda (c m track)\n",
  "    (begin\n",
  "      (puppeteer_say c m track)\n",
  "      (director_wait_message c)\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  ";@brief: say_and_go <character> <message>\n",
  ";@description: similar to 'say', but the control is returned immediately to the program before the end of the message\n",
  "(define say_and_go\n",
  "  (lambda (c m)\n",
  "    (begin\n",
  "      (puppeteer_say c m (+ 1 (* (length m) 0.05)))\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  ";@brief: talk_and_go <character> <message> <track>\n",
  ";@description: similar to 'talk', but the control is returned immediately to the program before the end of the audio track\n",
  "(define talk_and_go\n",
  "  (lambda (c m track)\n",
  "    (begin\n",
  "      (puppeteer_say c m track)\n",
  "      )\n",
  "    )\n",
  "  )\n",
  "\n",
  ";@brief: animation <character> <animation>\n",
  ";@description: changes the state/animation of <character> to <animation>\n",
  "(define animation\n",
  "  (lambda (c m)\n",
  "    (begin\n",
  "      (puppeteer_set c m)\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  ";@brief: main_control <character>\n",
  ";@description: gives the main control of the game to the character <character>\n",
  "(define main_control\n",
  "  (lambda (c)\n",
  "    (begin\n",
  "      (director_camera_follow c -100.0 1.0)\n",
  "      (puppeteer_enable_control c)\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  ";@brief: get_dialog <dialog list> <language> <number>\n",
  ";@description: returns the message number <number> stored in the <dialog list> list in the <language> language\n",
  "(define get_dialog\n",
  "  (lambda (d lang n)\n",
  "    (begin\n",
  "      (if (= n 0)\n",
  "        (if (= lang 0)\n",
  "          (car (car d))\n",
  "          (cdr (car d))\n",
  "          )\n",
  "        (get_dialog (cdr d) lang (- n 1))\n",
  "        )\n",
  "      )\n",
  "    )\n",
  "  )\n\n",
  NULL
};
typedef struct s_dialog_line {
  int code;
  char actor[d_string_buffer], looking_at[d_string_buffer], animation[d_string_buffer], *italian_dialog, *english_dialog;
  struct s_dialog_line *next;
} s_dialog_line;
struct s_dialog_line *root, *tail;
char author[d_string_buffer], name[d_string_buffer], location[d_string_buffer], description[d_string_buffer];
unsigned int lines;
enum e_dialog_line {
  e_dialog_code = 0,
  e_dialog_actor,
  e_dialog_looking_at,
  e_dialog_animation,
  e_dialog_italian,
  e_dialog_english,
  e_dialog_NULL
};
char *f_next_valid_occurrence(char *pointer, char character, t_boolean *string_covered) {
  const char string_container[] = {
    '\'',
    '"',
    0
  };
  char container_character = 0, *result, *next_pointer = pointer;
  int index;
  *string_covered = d_false;
  for (index = 0; string_container[index]; ++index) {
    if (*pointer == string_container[index]) {
      *string_covered = d_true;
      container_character = string_container[index];
      break;
    }
  }
  while ((result = strchr(next_pointer, character))) {
    if ((!container_character) || (*(result - 1) == container_character))
      break;
    next_pointer = (result + 1);
  }
  return result;
}
void f_add_field(struct s_dialog_line *entry, enum e_dialog_line dialog_state, const char *buffer, size_t length) {
  char string_code[d_string_buffer];
  int index;
  switch (dialog_state) {
    case e_dialog_code:
      strncpy(string_code, buffer, length);
      entry->code = atoi(string_code);
      break;
    case e_dialog_actor:
      strncpy(entry->actor, buffer, length);
      for (index = 0; index < length; ++index)
        entry->actor[index] = tolower(entry->actor[index]);
      break;
    case e_dialog_looking_at:
      strncpy(entry->looking_at, buffer, length);
      break;
    case e_dialog_animation:
      strncpy(entry->animation, buffer, length);
      break;
    case e_dialog_italian:
      entry->italian_dialog = (char *) malloc(length + 1);
      memcpy(entry->italian_dialog, buffer, length);
      break;
    case e_dialog_english:
      entry->english_dialog = (char *) malloc(length + 1);
      memcpy(entry->english_dialog, buffer, length);
  }
}
void f_append_line(char *buffer) {
  char *pointer = buffer, *next_character;
  struct s_dialog_line *new_entry;
  enum e_dialog_line dialog_state = e_dialog_code;
  size_t length;
  t_boolean string_covered;
  if ((new_entry = (struct s_dialog_line *) malloc(sizeof(struct s_dialog_line)))) {
    memset(new_entry, 0, sizeof(struct s_dialog_line));
    /* first we need to fill the structure with the string */
    while ((next_character = f_next_valid_occurrence(pointer, ',', &string_covered)) && (dialog_state != e_dialog_NULL)) {
      if (string_covered)
        ++pointer;
      if (next_character > pointer) {
        f_add_field(new_entry, dialog_state, pointer, (next_character - pointer - string_covered));
      }
      pointer = next_character + 1;
      ++dialog_state;
    }
    if ((*pointer) && (dialog_state != e_dialog_NULL)) {
      if (string_covered)
        ++pointer;
      if ((length = strlen(pointer)) > 0) {
        if (pointer[length - 1] == '\n')
          --length;
        f_add_field(new_entry, dialog_state, pointer, (length - string_covered));
      }
    }
    /* now we need to validate it: if valid, we can push it in the list */
    if (new_entry->code > 0) {
      if ((!tail) && (!root)) {
        root = new_entry;
        tail = root;
      } else {
        tail->next = new_entry;
        tail = new_entry;
      }
      ++lines;
    } else {
      if (strcmp(new_entry->actor, "code") == 0)
        strcpy(name, new_entry->looking_at);
      else if (strcmp(new_entry->actor, "location") == 0)
        strcpy(location, new_entry->looking_at);
      else if (strcmp(new_entry->actor, "description") == 0)
        strcpy(description, new_entry->looking_at);
      else if (strcmp(new_entry->actor, "author") == 0)
        strcpy(author, new_entry->looking_at);
      free(new_entry);
    }
  }
}
void f_dump_dialogs(const char *output) {
  FILE *stream = fopen(output, "w");
  struct s_dialog_line *current_dialog;
  int index, dialog = 0;
  char preview[d_preview_size];
  if (stream) {
    for (index = 0; output_header[index]; ++index)
      fprintf(stream, output_header[index]);
    fprintf(stream, ";Code name  : %s\n", name);
    fprintf(stream, ";Location   : %s\n", location);
    fprintf(stream, ";Author     : %s\n", author);
    fprintf(stream, ";Description: %s\n\n", description);
    fprintf(stream, ";Dialogs\n");
    fprintf(stream, "(define language (collector_get \"language\"))\n");
    fprintf(stream, "(define dialogs (list\n");
    fprintf(stream, "%s(cons ;0 default\n", d_char_tab);
    fprintf(stream, "%s \"\"\n", d_char_tab);
    fprintf(stream, "%s \"\")\n", d_char_tab);
    current_dialog = root;
    while (current_dialog) {
      if ((current_dialog->italian_dialog) && (current_dialog->english_dialog)) {
        fprintf(stream, "%s(cons ;%d %s\n", d_char_tab, ++dialog, current_dialog->actor);
        fprintf(stream, "%s \"%s\"\n", d_char_tab, current_dialog->english_dialog);
        fprintf(stream, "%s \"%s\")\n", d_char_tab, current_dialog->italian_dialog);
      }
      current_dialog = current_dialog->next;
    }
    fprintf(stream, "%snil\n", d_char_tab);
    fprintf(stream, "))\n\n");
    for (index = 0; output_functions[index]; ++index)
      fprintf(stream, output_functions[index]);
    fprintf(stream, ";Environment configuration (music, effect, whatever)\n");
    fprintf(stream, "(puppeteer_disable_control)\n\n");
    fprintf(stream, ";Action!\n");
    dialog = 0;
    current_dialog = root;
    while (current_dialog) {
      if ((current_dialog->italian_dialog) && (current_dialog->english_dialog)) {
        strncpy(preview, current_dialog->english_dialog, (d_preview_size - 1));
        if (strlen(preview) >= (d_preview_size - 1)) {
          preview[d_preview_size - 1] = 0;
          preview[d_preview_size - 2] = '.';
          preview[d_preview_size - 3] = '.';
          preview[d_preview_size - 4] = '.';
        }
        ++dialog;
        fprintf(stream, "(say \"%s\" (get_dialog dialogs language %d) \"%s_track%d\") ;preview: %s", current_dialog->actor, dialog, name, dialog, preview);
        if (strlen(current_dialog->looking_at) > 0)
          fprintf(stream, " | looking at %s", current_dialog->looking_at);
        if (strlen(current_dialog->animation) > 0)
          fprintf(stream, " | animation %s", current_dialog->animation);
        fprintf(stream, "\n");
      } else if (current_dialog->italian_dialog) {
        fprintf(stream, ";Script suggestion: %s\n", current_dialog->italian_dialog);
      }
      current_dialog = current_dialog->next;
    }
    fclose(stream);
  }
}
int main(int argc, char *argv[]) {
  FILE *stream;
  char buffer[d_string_max_line];
  if (argc == 3) {
    if ((stream = fopen(argv[1], "r"))) {
      while (!feof(stream)) {
        if (fgets(buffer, d_string_max_line, stream)) {
          f_append_line(buffer);
        }
      }
      fclose(stream);
      f_dump_dialogs(argv[2]);
    } else {
      fprintf(stderr, "[error] 404 file not found %s\n", argv[1]);
    }
  } else {
    fprintf(stderr, "Use: %s <file CSV with dialogs> <file LISP output>\n", argv[0]);
  }
  return 0;
}


