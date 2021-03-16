defmodule HarmonyLive.ChatRooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias HarmonyLive.ChatRooms.Guest
  alias HarmonyLive.Users.User

  schema "rooms" do
    field :join_link, :string
    field :keep_for, :naive_datetime
    belongs_to :users, User, foreign_key: :owner_id
    has_many :guests, Guest

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:keep_for, :join_link])
    |> cast_assoc(:users)
    |> validate_required([:keep_for, :join_link])
  end

  @doc false
  def room_creation_changeset(room, attrs) do
    room
    |> cast(attrs, [:keep_for, :join_link])
    |> validate_required([:keep_for, :join_link, :owner_id])
    |> unique_constraint(:join_link)
  end
end
