defmodule HomeworkWeb.MeetingLive.Index do
  use HomeworkWeb, :live_view

  alias Homework.Meetings
  alias Homework.Meetings.Meeting

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :meetings, Meetings.list_meetings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Meeting")
    |> assign(:meeting, Meetings.get_meeting!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Meeting")
    |> assign(:meeting, %Meeting{})
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Meetings")
    |> assign(:meetings, Meetings.list_meetings(params))
    |> assign(:form, to_form(%{}))
    |> assign(:meeting, nil)
  end

  def handle_event("search", params, socket) do
    {:noreply, push_patch(socket, to: ~p"/meetings?#{params}")}
  end

  @impl true
  def handle_info({HomeworkWeb.MeetingLive.FormComponent, {:saved, meeting}}, socket) do
    {:noreply, stream_insert(socket, :meetings, meeting |> Homework.Repo.preload(:users))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    meeting = Meetings.get_meeting!(id)
    {:ok, _} = Meetings.delete_meeting(meeting)

    {:noreply, stream_delete(socket, :meetings, meeting)}
  end
end
