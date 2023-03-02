defmodule HomeworkWeb.Plug.AssignYesterday do
  import Plug.Conn

  def init(options) do
    # initialize options
    options
  end

  def call(conn, _opts) do
    yesterday = Date.utc_today() |> Date.add(-1) |> Date.to_string()

    conn
    |> assign(:yesterday, yesterday)
  end
end
