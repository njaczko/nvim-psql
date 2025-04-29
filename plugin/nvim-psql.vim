if exists("g:loaded_nvim_psql")
    finish
endif
let g:loaded_nvim_psql = 1

command -nargs=1 PSQLInit lua require("nvim-psql").initPSQL(<f-args>)
command -nargs=0 InitBigQuery lua require("nvim-psql").initBigQuery()
command PSQLQuery lua require("nvim-psql").psqlQuery()
command BigQuery lua require("nvim-psql").bigQuery()
command PSQLHistory lua require("nvim-psql").history()
