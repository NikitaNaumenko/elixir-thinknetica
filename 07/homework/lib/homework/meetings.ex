defmodule Homework.Meetings do
  @moduledoc """
  The Meetings context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Meetings.Meeting

  @doc """
  Returns the list of meetings.

  ## Examples

      iex> list_meetings()
      [%Meeting{}, ...]

  """
  @spec list_meetings(params :: map()) :: [Meeting.t()]
  def list_meetings(params \\ %{}) do
    name = Map.get(params, "name", "")
    date = Map.get(params, "scheduled_at", "")

    from(m in Meeting, preload: [:users])
    |> where_name(name)
    |> where_date(date)
    |> Repo.all()
  end

  @doc """
  Gets a single meeting.

  Raises `Ecto.NoResultsError` if the Meeting does not exist.

  ## Examples

      iex> get_meeting!(123)
      %Meeting{}

      iex> get_meeting!(456)
      ** (Ecto.NoResultsError)

  """

  @spec get_meeting!(id :: non_neg_integer()) :: Meeting.t()
  def get_meeting!(id), do: Repo.get!(Meeting, id)

  @doc """
  Creates a meeting.

  ## Examples

      iex> create_meeting(%{field: value})
      {:ok, %Meeting{}}

      iex> create_meeting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_meeting(attrs :: map()) :: {:ok, Meeting.t()} | {:error, Ecto.Changeset.t()}
  def create_meeting(attrs \\ %{}) do
    %Meeting{}
    |> Meeting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meeting.

  ## Examples

      iex> update_meeting(meeting, %{field: new_value})
      {:ok, %Meeting{}}

      iex> update_meeting(meeting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_meeting(meeting :: Meeting.t(), attrs :: map()) ::
          {:ok, Meeting.t()} | {:error, Ecto.Changeset.t()}
  def update_meeting(%Meeting{} = meeting, attrs) do
    meeting
    |> Meeting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a meeting.

  ## Examples

      iex> delete_meeting(meeting)
      {:ok, %Meeting{}}

      iex> delete_meeting(meeting)
      {:error, %Ecto.Changeset{}}

  """

  @spec delete_meeting(Meeting.t()) :: {:ok, Meeting.t()} | {:error, Ecto.Changeset.t()}
  def delete_meeting(%Meeting{} = meeting) do
    Repo.delete(meeting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meeting changes.

  ## Examples

      iex> change_meeting(meeting)
      %Ecto.Changeset{data: %Meeting{}}

  """
  @spec change_meeting(meeting :: Meeting.t(), attrs :: map()) :: Ecto.Changeset.t()
  def change_meeting(%Meeting{} = meeting, attrs \\ %{}) do
    Meeting.changeset(meeting, attrs)
  end

  defp where_name(query, ""), do: query

  defp where_name(query, name) do
    name = "%#{name}"
    from e in query, where: like(e.name, ^name)
  end

  defp where_date(query, ""), do: query

  defp where_date(query, date) do
    date = Date.from_iso8601!(date)

    from e in query,
      where: fragment("?::date", e.scheduled_at) == ^date
  end
end
