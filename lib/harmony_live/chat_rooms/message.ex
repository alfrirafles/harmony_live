defmodule HarmonyLive.ChatRooms.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias HarmonyLive.ChatRooms.Guest

  schema "messages" do
    field :content, :string
    belongs_to :guests, Guest, foreign_key: :sender_id, references: :guest_id

    timestamps()
  end

  @doc false
  def create_changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :sender_id])
    |> validate_required([:content, :sender_id])
  end
end
