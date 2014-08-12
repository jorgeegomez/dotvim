" Php3
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.php,*.php3,*.module     setfiletype php
augroup END

