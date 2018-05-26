# gsf_3names_read
Helping Gynvael test unzip software and libraries: [Link](https://t.co/RbFwEWatJA)

This program uses *GNOME Structured File Library (GSF)* to list contents of the file.

When executed gives the output:
```
Number of files found: 1
Name of the file: central_directory_name.txt

Check each file individually:

local_file_header_name.txt: Not found

local_info_zip_1.txt: Not found

local_info_zip_2.txt: Not found

central_directory_name.txt: Found

central_info_zip_1.txt: Not found

central_info_zip_2.txt: Not found
```

But this may be different depending on which version of the library you are using.

Above is tested on **1.14.43**

Compile and run in dedicated directory (e.g. *./build*)
