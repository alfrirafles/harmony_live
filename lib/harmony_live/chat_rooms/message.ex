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
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
