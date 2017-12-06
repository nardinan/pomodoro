#include <stdio.h>
#include <string.h>
#include <ctype.h>
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

int f_extract_string(const char *file) {
    FILE *stream = fopen(file, "r");
    char buffer[MAXLEN], *filtered_string, *filtered_file_name = (char *)file, *next_pointer, *filtered_character_name;
    enum e_extract_statuses status = e_extract_status_ignore;
    while ((next_pointer = strchr(filtered_file_name, '/'))) {
        filtered_file_name = next_pointer + 1;
    }
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
                            if (strcmp(filtered_character_name, "default") == 0) {
                                status = e_extract_status_ignore;
                                break;
                            }
                            printf("%s|%s|", filtered_file_name, filtered_character_name);
                        } else 
                            printf("%s||", filtered_file_name);
                        status = e_extract_status_read_english;
                    }
                    break;
                case e_extract_status_read_italian:
                    filtered_string = f_extract_purge(buffer);
                    if (strlen(filtered_string) > 0) {
                        printf("%s\n", filtered_string);
                    } else
                        printf("\n");
                    status = e_extract_status_ignore;
                    break;
                case e_extract_status_read_english:
                    filtered_string = f_extract_purge(buffer);
                    if (strlen(filtered_string) > 0) {
                        printf("%s|", filtered_string);
                    }
                    status = e_extract_status_read_italian;
            };
        }
    }
    return 0;
}

int main (int argc, char *argv[]) {
    for (int index = 1; index < argc; ++index)
        f_extract_string(argv[index]);

    return 0;
}
