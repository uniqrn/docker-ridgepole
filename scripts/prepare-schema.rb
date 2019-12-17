require 'pg'

connection=PG::connect( host: ENV["DB_HOST"], user: ENV["DB_USER"], password: ENV["DB_PASSWORD"], dbname: ENV["DB_NAME"], port: 5432)
begin
  connection.exec("CREATE SCHEMA IF NOT EXISTS #{ENV["DB_SCHEMA"]};")
  connection.exec("CREATE EXTENSION IF NOT EXISTS pgcrypto SCHEMA #{ENV["DB_SCHEMA"]};")
ensure
  connection.finish
end
