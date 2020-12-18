#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <libgen.h>
#define d_space_character(a) (((a)==' ')||((a)=='\t'))
#define d_final_character(a) (((a)=='\0')||((a)=='\n')||((a)=='\r'))
#define d_string_empty(s) ((s)[0]=='\0')
#define MAXENTRIES 1024
#define MAXLEN 2048
typedef enum e_extract_statuses {
  e_extract_status_read_italian,
  e_extract_status_read_english,
  e_extract_status_ignore
} e_extract_statuses;
char *f_extract_purge(char *buffer) {
  char *result = buffer, *pointer;
  size_t final = strlen(buffer);
  if ((pointer = strchr(buffer, '"')))
    result = (pointer + 1);
  if ((pointer = strchr(result, '"')))
    *pointer = 0;
  return result;
}
char *f_string_trim(char *string) {
  size_t length = strlen(string);
  char *begin = string, *final = (string + length) - 1;
  while ((d_space_character(*begin) || (d_space_character(*final)) || (d_final_character(*final))) && (final >= begin)) {
    if (d_space_character(*begin))
      begin++;
    if ((d_space_character(*final)) || (d_final_character(*final))) {
      *final = '\0';
      final--;
    }
  }
  if (begin > string)
    memmove(string, begin, strlen(begin) + 1);
  return string;
}
int f_string_validate(char *string) {
  /* to be validated, a string cannot contain anything but the ascii table printable characters, 
   * and it should not contain any " */
  size_t length = strlen(string);
  for (unsigned int index = 0; index < length; ++index)
    if ((string[index] == '"') ||
        (string[index] < 32) || 
        (string[index] > 126)) {
      fprintf(stderr, "character %d ('%c') of the string '%s' is not valid\n", index,
          string[index], string);
      return 0;
    }
  return 1;
}
int f_injector_string(const char *file) {
  struct s_scoped_entry {
    char italian_sentence[MAXLEN], english_sentence[MAXLEN], character[MAXLEN];
  } final_container[MAXENTRIES];
  enum e_scoped_extracts {
    e_scoped_extract_file_name = 0,
    e_scoped_extract_character_name,
    e_scoped_extract_english_sentence,
    e_scoped_extract_italian_sentence,
    e_scoped_extract_NULL
  } current_extraction;
  FILE *input_stream = fopen(file, "r"), *old_input_stream, *new_input_stream;
  char buffer[MAXLEN], internal_buffer[MAXLEN], *text_block[e_scoped_extract_NULL], *current_pointer, *previous_pointer, selected_file[MAXLEN] = {0}, 
       temporary_file[MAXLEN];
  unsigned int container_index = 0;
  int ignore_content = 0;
  if (input_stream) {
    memset(selected_file, 0, MAXLEN);
    while (!feof(input_stream)) {
      memset(buffer, 0, MAXLEN);
      if (fgets(buffer, MAXLEN, input_stream)) {
        current_pointer = buffer;
        for (unsigned int index = 0; index < e_scoped_extract_NULL; ++index)
          text_block[index] = NULL;
        for (unsigned int index = 0; index < e_scoped_extract_NULL; ++index) {
          text_block[index] = current_pointer;
          if (*text_block[index] != '|') {
            ++current_pointer;
            while ((*text_block[index] == '\n') ||
                (*text_block[index] == ' ') ||
                (*text_block[index] == '\t')) {
              if (strlen(text_block[index]) > 0)
                ++text_block[index];
            }
          } else {
            *text_block[index] = '|';
          }
          if (strlen(current_pointer) > 0) {
            if ((current_pointer = strchr(current_pointer, '|'))) {
              *current_pointer = 0;
              ++current_pointer;
            }
          } else 
            break;
        }
        if ((strlen(selected_file) > 0) && (strcmp(selected_file, text_block[e_scoped_extract_file_name]) != 0)) {
          snprintf(temporary_file, MAXLEN, "/tmp/%s", basename(selected_file));
          if ((old_input_stream = fopen(selected_file, "r")) && (new_input_stream = fopen(temporary_file, "w"))) {
            ignore_content = 0;
            while (!feof(old_input_stream)) {
              memset(internal_buffer, 0, MAXLEN);
              if (fgets(internal_buffer, MAXLEN, old_input_stream)) {
                if (strstr(internal_buffer, "(define dialogs (list")) {
                  ignore_content = 1;
                  fprintf(new_input_stream, "(define dialogs (list\n");
                  for (unsigned int index = 0; index < container_index; ++index) {
                    fprintf(new_input_stream, "\t\t(cons ;%d %s\n", index, final_container[index].character);
                    fprintf(new_input_stream, "\t\t\t\"%s\"    \n", final_container[index].english_sentence);
                    fprintf(new_input_stream, "\t\t\t\"%s\")   \n", final_container[index].italian_sentence);
                  }
                  fprintf(new_input_stream, "\t\tnil\n");
                  fprintf(new_input_stream, "\t\t))\n");
                }
                if (!ignore_content) {
                  fprintf(new_input_stream, "%s", internal_buffer);
                }
                if (strstr(internal_buffer, "))")) {
                  ignore_content = 0;
                }
              }
            }
            fclose(old_input_stream);
            fclose(new_input_stream);
            printf("file updated: %s\n", selected_file);
            rename(temporary_file, selected_file);
          }
          container_index = 0;
        }
        strcpy(selected_file, text_block[e_scoped_extract_file_name]);
        memset(final_container[container_index].character, 0, MAXLEN);
        memset(final_container[container_index].english_sentence, 0, MAXLEN);
        memset(final_container[container_index].italian_sentence, 0, MAXLEN);
        if (text_block[e_scoped_extract_character_name]) {
          strcpy(final_container[container_index].character, text_block[e_scoped_extract_character_name]);
          f_string_trim(final_container[container_index].character);
          if (!f_string_validate(final_container[container_index].character))
            exit(1);
        }
        if (text_block[e_scoped_extract_english_sentence]) {
          strcpy(final_container[container_index].english_sentence, text_block[e_scoped_extract_english_sentence]);
          f_string_trim(final_container[container_index].english_sentence);
          if (!f_string_validate(final_container[container_index].character))
            exit(1);
        }
        if (text_block[e_scoped_extract_italian_sentence]) {
          strcpy(final_container[container_index].italian_sentence, text_block[e_scoped_extract_italian_sentence]);
          f_string_trim(final_container[container_index].italian_sentence);
          if (!f_string_validate(final_container[container_index].character))
            exit(1);
        }
        ++container_index;
      }
    }
    fclose(input_stream);
  }
}
int f_extract_string(const char *file) {
  FILE *stream = fopen(file, "r");
  char buffer[MAXLEN], *filtered_string, *filtered_file_name = (char *) file, *next_pointer, *filtered_character_name;
  enum e_extract_statuses status = e_extract_status_ignore;
  if (stream) {
    while (!feof(stream)) {
      memset(buffer, 0, MAXLEN);
      if (fgets(buffer, MAXLEN, stream)) {
        switch (status) {
          case e_extract_status_ignore:
            if (strstr(buffer, "cons")) {
              if ((filtered_character_name = strchr(buffer, ';'))) {
                ++filtered_character_name;
                while ((*filtered_character_name == ' ') || (isdigit(*filtered_character_name)))
                  ++filtered_character_name;
                if ((next_pointer = strchr(filtered_character_name, '\n')))
                  *next_pointer = 0;
                printf("%s|%s|", filtered_file_name, filtered_character_name);
              } else
                printf("%s|default|", filtered_file_name);
              status = e_extract_status_read_english;
            }
            break;
          case e_extract_status_read_italian:
            filtered_string = f_extract_purge(buffer);
            if (strlen(filtered_string) > 0)
              printf("%s\n", filtered_string);
            else
              printf("\n");
            status = e_extract_status_ignore;
            break;
          case e_extract_status_read_english:
            filtered_string = f_extract_purge(buffer);
            if (strlen(filtered_string) > 0)
              printf("%s|", filtered_string);
            else
              printf("|");
            status = e_extract_status_read_italian;
        };
      }
    }
    fclose(stream);
  }
  return 0;
}
int main(int argc, char *argv[]) {
  if (argc > 1) {
    if (strcmp(argv[1], "-x") == 0) {
      for (int index = 2; index < argc; ++index)
        f_extract_string(argv[index]);
    } else if (strcmp(argv[1], "-i") == 0) {
      for (int index = 2; index < argc; ++index)
        f_injector_string(argv[index]);
    }
  }
  return 0;
}
