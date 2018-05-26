#include <gsf/gsf.h>
#include <stdio.h>

#define THREE_NAMES_LOCATION "../res/3names.zip"

typedef struct {
  GsfInput *source;
  GsfInfile *file;
  GError *err;
} Data;

char const RED[] = {0x1B, '[', '3', '1', ';', '1', 'm', 0};
char const GREEN[] = {0x1B, '[', '3', '2', ';', '1', 'm', 0};
char const RESET[] = {0x1B, '[', '0', 'm', 0};

/*  File names to check individually  */
int const number_of_names = 6;
char const *names[] = {
  "local_file_header_name.txt",
  "local_info_zip_1.txt",
  "local_info_zip_2.txt",
  "central_directory_name.txt",
  "central_info_zip_1.txt",
  "central_info_zip_2.txt"
};

void
data_free(Data *data)
{
  if (data->err != NULL)
    g_clear_error(&(data->err));
  if (data->file != NULL)
    g_object_unref(data->file);
  if (data->source != NULL)
    g_object_unref(data->source);
}

int
report_error(Data *data)
{
  int code = data->err->code;
  g_printerr("%s\n", data->err->message);
  data_free(data);
  return code;
}

int
main(int argc, char *argv[])
{
  int num_of_children = 0;
  Data data = {0};
  
  data.source = gsf_input_stdio_new(THREE_NAMES_LOCATION, &(data.err));
  if (data.source == NULL || data.err != NULL)
    return report_error(&data);
  
  data.file = gsf_infile_zip_new (data.source, &(data.err));
  if (data.file == NULL || data.err != NULL)
    return report_error(&data);
  
  num_of_children = gsf_infile_num_children(data.file);
  printf("\nNumber of files found: %s%i%s\n", RED, num_of_children, RESET);
  
  for (size_t i = 0; i < num_of_children; i++) {
    printf("Name of the file: %s%s%s\n", RED, gsf_infile_name_by_index(data.file, i), RESET);
  }
  
  printf("\n%s\n\n", "Check each file individually:");
  
  for (size_t i = 0; i < number_of_names; i++) {
    GsfInput *in = gsf_infile_child_by_name(data.file, names[i]);
    if (in == NULL)
      printf("%s%s%s: Not found\n", RED, names[i], RESET);
    else
    {
      printf("%s%s%s: %sFound%s\n", RED, names[i], RESET, GREEN, RESET);
      g_object_unref(in);
    }
    printf("\n");
  }
  
  data_free(&data);
  return 0;
}