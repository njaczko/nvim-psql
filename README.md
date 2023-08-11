# nvim-psql

A minimal plugin that wraps the `psql` CLI so that queries and results can be
edited with Neovim. It also keeps a simple history of queries run using the
plugin.

## Usage

First, pass your Postgres DSN to the `PSQLInit` command. For example:

```sh
nvim -c "PSQLInit host=0.0.0.0 port=5432 sslmode=disable dbname=postgres user=postgres"
# Or, if you have your DSN in an environment variable:
nvim -c "PSQLInit $DSN"
```

`PSQLInit` will open buffers for the query and output.

Write your query in the `query` buffer, then run `:PSQLQuery` to execute it.

Run `:PSQLHistory` to view queries that you've made with nvim-psql.

All files and directories created by this plugin are stored in the `$HOME/.nvim-psql` directory.
