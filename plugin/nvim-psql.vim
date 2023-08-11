if exists("g:loaded_nvim_psql")
    finish
endif
let g:loaded_nvim_psql = 1

command -nargs=1 PSQLInit lua require("nvim-psql").init(<f-args>)
command PSQLQuery lua require("nvim-psql").query()
command PSQLHistory lua require("nvim-psql").history()
