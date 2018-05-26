; ZIP Template.
; by gynvael.coldwind//vx
[bits 32]

; Let's make a ZIP! :)

; Note: how to calculate crc-32? easy! just try to unpack the file
;       with command-line unzip, it shows the good crc ;p


; File #1 Local File Header
file_1:
dd 0x04034b50             ; local file header signature     4 bytes  (0x04034b50)
dw 0x000a                 ; version needed to extract       2 bytes  (1.0)
dw 0                      ; general purpose bit flag        2 bytes
dw 0                      ; compression method              2 bytes  (0 - store)
dw 0                      ; last mod file time              2 bytes
dw 0                      ; last mod file date              2 bytes
dd 0x9ea71e4b             ; crc-32                          4 bytes
dd .data_e - .data_s      ; compressed size                 4 bytes
dd .data_e - .data_s      ; uncompressed size               4 bytes
dw .name_e - .name_s      ; file name length                2 bytes
dw .extra_e - .extra_s    ; extra field length              2 bytes

; name
.name_s:
db "local_file_header_name.txt"
.name_e:

; extra header would be here
.extra_s:

; Info-ZIP number one
dw 0x7075                 ; Info-ZIP Unicode Path Extra Field
dw .e1e - .e1s            ; TSize         Short       total data size for this block
.e1s:
db 1                      ; Version       1 byte      version of this extra field, currently 1
dd 0x78092dfc             ; NameCRC32     4 bytes     File Name Field CRC32 Checksum
db "local_info_zip_1.txt" ; UnicodeName   Variable    UTF-8 version of the entry File Name
.e1e:

; Info-ZIP number two
dw 0x7075                 ; Info-ZIP Unicode Path Extra Field
dw .e2e - .e2s            ; TSize         Short       total data size for this block
.e2s:
db 1                      ; Version       1 byte      version of this extra field, currently 1
dd 0x3fa9572c             ; NameCRC32     4 bytes     File Name Field CRC32 Checksum
db "local_info_zip_2.txt" ; UnicodeName   Variable    UTF-8 version of the entry File Name
.e2e:

.extra_e:


; file data (this is stored, so plaintext)
.data_s:
db "Just enter any data here.", 0x0d, 0x0a
.data_e:

; -------------------------------------------------------------------

central_directory:
.s:
; Central directory entries
dd 0x02014b50             ; central file header signature   4 bytes  (0x02014b50)
dw 0x031e                 ; version made by                 2 bytes
dw 0x000a                 ; version needed to extract       2 bytes
dw 0                      ; general purpose bit flag        2 bytes
dw 0                      ; compression method              2 bytes
dw 0                      ; last mod file time              2 bytes
dw 0                      ; last mod file date              2 bytes
dd 0x9ea71e4b             ; crc-32                          4 bytes
dd file_1.data_e - file_1.data_s ; compressed size                 4 bytes
dd file_1.data_e - file_1.data_s ; uncompressed size               4 bytes
dw .name_e - .name_s      ; file name length                2 bytes
dw .extra_e - .extra_s    ; extra field length              2 bytes
dw 0                      ; file comment length             2 bytes
dw 0                      ; disk number start               2 bytes
dw 0                      ; internal file attributes        2 bytes
dd 0                      ; external file attributes        4 bytes
dd file_1                 ; relative offset of local header 4 bytes

; name
.name_s:
db "central_directory_name.txt"
.name_e:

; extra header would be here
.extra_s:
; Info-ZIP number two
dw 0x7075                 ; Info-ZIP Unicode Path Extra Field
dw .e1e - .e1s            ; TSize         Short       total data size for this block
.e1s:
db 1                      ; Version       1 byte      version of this extra field, currently 1
dd 0xf8dcc88a             ; NameCRC32     4 bytes     File Name Field CRC32 Checksum
db "central_info_zip_1.txt" ; UnicodeName   Variable    UTF-8 version of the entry File Name
.e1e:

; Info-ZIP number two
dw 0x7075                 ; Info-ZIP Unicode Path Extra Field
dw .e2e - .e2s            ; TSize         Short       total data size for this block
.e2s:
db 1                      ; Version       1 byte      version of this extra field, currently 1
dd 0xbf7cb25a             ; NameCRC32     4 bytes     File Name Field CRC32 Checksum
db "central_info_zip_2.txt" ; UnicodeName   Variable    UTF-8 version of the entry File Name
.e2e:
.extra_e:

; comment would be here

.e:

; -------------------------------------------------------------------
;  End of central directory record:

dd 0x06054b50             ; end of central dir signature    4 bytes  (0x06054b50)
dw 0                      ; number of this disk             2 bytes
dw 0                      ; number of the disk with the
                          ; start of the central directory  2 bytes
dw 1                      ; total number of entries in the
                          ; central directory on this disk  2 bytes
dw 1                      ; total number of entries in
                          ; the central directory           2 bytes
dd central_directory.e - central_directory.s
                          ; size of the central directory   4 bytes
dd central_directory      ; offset of start of central
                          ; directory with respect to
                          ; the starting disk number        4 bytes
dw 0                      ; .ZIP file comment length        2 bytes

; .ZIP file comment       (variable size)



; -------------------------------------------------------------------
; End of file.
end_of_file:


; vim: syntax=nasm
