defmodule HarmonyLive.ChatRooms do
  @moduledoc """
  The ChatRooms context.
  """

  import Ecto.Query, warn: false
  alias HarmonyLive.Repo
  alias HarmonyLive.ChatRooms.{Room, Guest}
  alias HarmonyLive.Users

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creating a room as well as its user based on the following parameters:
  display_name - string
  length_minutes - integer

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %{"display_name" => name, "length_minutes" => duration} = attrs
    attrs = Map.put(attrs, "keep_for", parse_existence_time(seconds: duration, utc_plus: 8))
            |> Map.put("join_link", Faker.String.base64(6))
    {:ok, user} = Users.create_user(%{"display_name" => name})

    user
    |> Ecto.build_assoc(:rooms)
    |> Room.room_creation_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Add guest to the room based on a valid invite link.

  Parameters:
  display_name - string
  join_link - string

  Returns the room with preloaded guests list.
  """
  def append_guest(attrs) do
    %{"display_name" => name, "join_link" => join_link} = attrs
    case Repo.get_by(Room, join_link: join_link) do
      %Room{} = room ->
        {:ok, user} = Users.create_user(%{"display_name" => name})
        room
        |> Ecto.build_assoc(:guests, [guest_id: room.id])
        |> Guest.create_changeset(%{"room_id" => room.id, "guest_id" => user.id})
        |> Repo.insert()

        room
        |> Repo.preload(:guests)
      nil -> {:error, "Invalid join link."}
    end
  end

  @doc """

  """
  def append_message(attrs) do

  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  defp parse_existence_time(seconds: duration, utc_plus: hours) do
    NaiveDateTime.utc_now
    |> NaiveDateTime.add(hours * 3600 + duration * 60, :second)
    |> NaiveDateTime.truncate(:second)
  end
end
