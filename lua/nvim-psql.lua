local M = {}

function exec(cmd)
  output = vim.call('system', cmd)
  if (vim.v.shell_error ~= 0) then error(string.format("'%s' failed: %s", cmd, output)) end
  return output
end

function M.initPSQL(dsn)
  if (dsn == nil or dsn == '') then error("Postgres DSN is required") end

  local nvim_psql_dir = os.getenv('HOME') .. '/.nvim-psql/'
  if vim.fn.isdirectory(nvim_psql_dir) == 0 then
    vim.fn.mkdir(nvim_psql_dir)
  end

  M.query_file_path = nvim_psql_dir .. 'query'
  M.output_file_path = nvim_psql_dir .. 'output'
  M.history_file_path = nvim_psql_dir .. 'history'
  M.postgres_dsn = dsn

  vim.cmd.edit(M.output_file_path)
  vim.cmd.vsplit(M.query_file_path)
  vim.opt.ft='sql'
end

function M.initBigQuery()
  local nvim_psql_dir = os.getenv('HOME') .. '/.nvim-psql-bigquery/'
  if vim.fn.isdirectory(nvim_psql_dir) == 0 then
    vim.fn.mkdir(nvim_psql_dir)
  end

  -- TODO DRY in initPSQL. Or, make new files for the BQ queries
  M.query_file_path = nvim_psql_dir .. 'query'
  M.output_file_path = nvim_psql_dir .. 'output'
  M.history_file_path = nvim_psql_dir .. 'history'
  M.postgres_dsn = dsn

  vim.cmd.edit(M.output_file_path)
  vim.cmd.vsplit(M.query_file_path)
  vim.opt.ft='sql'
end

function M.psqlQuery()
  vim.cmd.wa()
  stdout = exec(string.format(
     "psql -d '%s' -f '%s' -o '%s'",
     M.postgres_dsn, M.query_file_path, M.output_file_path
  ))
  exec(string.format(
    "cat %s >> %s",
    M.query_file_path, M.history_file_path
  ))
  vim.cmd.bufdo('e')
  print(stdout)
end

function M.bigQuery()
  vim.cmd.wa()
  stdout = exec(string.format(
    "bq query --max_rows=100000 --nouse_legacy_sql \"$(cat %s)\" > %s",
    M.query_file_path, M.output_file_path
  ))
  -- TODO DRY
  exec(string.format(
    "cat %s >> %s",
    M.query_file_path, M.history_file_path
  ))
  vim.cmd.bufdo('e')
  print(stdout)
end

function M.history()
  vim.cmd('belowright split ' .. M.history_file_path)
end

return M
