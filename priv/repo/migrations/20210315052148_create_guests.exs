defmodule HarmonyLive.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :room_id, references(:rooms, on_delete: :delete_all), null: false
      add :guest_id, references(:users, on_delete: :delete_all, name: :guest_id), null: false

      timestamps()
    end

    create unique_index(:guests, [:room_id, :guest_id], name: :unique_guest)
  end
end
