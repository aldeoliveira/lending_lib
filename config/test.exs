import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :lending_lib, LendingLib.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "lending_lib_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lending_lib, LendingLibWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "CpHDtvh3ROV9tB9e6dwgY9RNam0CXplRFru4SeZyxU/WlaYnlSafppwdrjxyf1HZ",
  server: false

# In test we don't send emails.
config :lending_lib, LendingLib.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Ease up the number of hashing rounds to speed up our test suite
config :pbkdf2_elixir, :rounds, 1
