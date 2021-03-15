defmodule HarmonyLive.Repo do
  use Ecto.Repo,
    otp_app: :harmony_live,
    adapter: Ecto.Adapters.Postgres
end
