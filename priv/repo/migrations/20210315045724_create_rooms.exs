defmodule HarmonyLive.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :keep_for, :naive_datetime
      add :join_link, :string
      add :owner_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index :rooms, :join_link
  end
end
