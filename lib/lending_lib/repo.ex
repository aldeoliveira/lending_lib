defmodule LendingLib.Repo do
  use Ecto.Repo,
    otp_app: :lending_lib,
    adapter: Ecto.Adapters.Postgres
end
