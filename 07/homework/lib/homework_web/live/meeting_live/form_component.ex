defmodule HomeworkWeb.MeetingLive.FormComponent do
  use HomeworkWeb, :live_component

  alias Homework.Meetings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage meeting records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="meeting-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:scheduled_at]} type="date" label="Scheduled at" />
        <.inputs_for :let={fp} field={@form[:user_meetings]}>
          <.input
            field={fp[:user_id]}
            type="select"
            label="Users"
            options={Homework.Users.list_users() |> Enum.map(&{&1.username, &1.id})}
          />
        </.inputs_for>
        <button type="button" phx-click="add-user" phx-target={@myself}>Add</button>

        <:actions>
          <.button phx-disable-with="Saving...">Save Meeting</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{meeting: meeting} = assigns, socket) do
    changeset = Meetings.change_meeting(meeting)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"meeting" => meeting_params}, socket) do
    changeset =
      socket.assigns.meeting
      |> Meetings.change_meeting(meeting_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("add-user", _, socket) do
    user_meeting = %Homework.Users.Meeting{} |> Homework.Users.Meeting.changeset(%{})

    user_meetings =
      Map.get(socket.assigns.form.source.changes, :user_meetings, []) ++ [user_meeting]

    changeset =
      socket.assigns.form.source
      |> Map.put(:changes, %{user_meetings: user_meetings})

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"meeting" => meeting_params}, socket) do
    save_meeting(socket, socket.assigns.action, meeting_params)
  end

  defp save_meeting(socket, :edit, meeting_params) do
    case Meetings.update_meeting(socket.assigns.meeting, meeting_params) do
      {:ok, meeting} ->
        notify_parent({:saved, meeting})

        {:noreply,
         socket
         |> put_flash(:info, "Meeting updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_meeting(socket, :new, meeting_params) do
    case Meetings.create_meeting(meeting_params) do
      {:ok, meeting} ->
        notify_parent({:saved, meeting})

        {:noreply,
         socket
         |> put_flash(:info, "Meeting created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
