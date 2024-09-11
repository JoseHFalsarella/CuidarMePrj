defmodule CuidarMePrj.Repo do
  use Ecto.Repo,
    otp_app: :cuidarMePrj,
    adapter: Ecto.Adapters.Postgres
end
