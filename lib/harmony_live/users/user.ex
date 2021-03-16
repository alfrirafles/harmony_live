defmodule HarmonyLive.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias HarmonyLive.ChatRooms.{Room, Guest}

  schema "users" do
    field :display_name, :string
    has_one :rooms, Room, foreign_key: :owner_id
    has_one :guests, Guest, foreign_key: :guest_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:display_name])
    |> validate_required([:display_name])
    |> validate_length(:display_name, min: 1)
  end

  @doc false
  def open_room_changeset(user, attrs)  do
    user
    |> change(attrs["display_name"])
  end
end
