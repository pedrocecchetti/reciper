defmodule Reciper.Repo do
  use Ecto.Repo,
    otp_app: :reciper,
    adapter: Ecto.Adapters.Postgres
end
