defmodule HarmonyLive.ChatRooms.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  alias HarmonyLive.ChatRooms.{Room, Message}
  alias HarmonyLive.Users.User

  schema "guests" do
    belongs_to :rooms, Room, foreign_key: :room_id
    belongs_to :users, User, foreign_key: :guest_id

    has_many :messages, Message, foreign_key: :sender_id

    timestamps()
  end

  @doc false
  def create_changeset(guest, attrs) do
    guest
    |> cast(attrs, [:room_id, :guest_id])
    |> validate_required([:room_id, :guest_id])
    |> unique_constraint(:unique_guest, name: :unique_guest)
  end
end
