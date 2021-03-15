defmodule HarmonyLive.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string, null: false
      add :sender_id, references(:guests, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
