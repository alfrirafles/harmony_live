defmodule HarmonyLiveWeb.PageLive.FormComponent do
  use HarmonyLiveWeb, :live_component

  alias HarmonyLive.ChatRooms

  @impl true
  def update(%{room: room} = assigns, socket) do
    changeset = ChatRooms.change_room(room)

    {:ok,
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
    }
  end

  @impl false
  def handle_event("validate", %{"room" => room_params}, socket) do
    changeset = socket.assign.room
                |> ChatRooms.change_room(room_params)
                |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end