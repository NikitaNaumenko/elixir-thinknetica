defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]
  @left_rotate %{:north => :west, :west => :south, :south => :east, :east => :north}
  @right_rotate %{:north => :east, :east => :south, :south => :west, :west => :north}
  @advance %{:north => {0, 1}, :east => {1, 0}, :south => {0, -1}, :west => {-1, 0}}

  @doc """
  Create a Robot Simulator given an initial direction and position.


  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %{direction: :north, position: {0, 0}}

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.to_charlist(instructions)
    |> step(robot)
  end

  defp step(_lst, {:error, msg}), do: {:error, msg}
  defp step([], robot), do: robot
  defp step([h | t], robot), do: step(t, action(h, robot))

  defp action(?L, robot), do: rotate(@left_rotate, robot)
  defp action(?R, robot), do: rotate(@right_rotate, robot)
  defp action(?A, robot), do: advance(@advance, robot)
  defp action(_, _robot), do: {:error, "invalid instruction"}

  defp rotate(instruction, robot) do
    %{robot | direction: Map.fetch!(instruction, robot.direction)}
  end

  defp advance(instruction, robot) do
    with direction <- direction(robot),
         {x, y} <- position(robot),
         {x_delta, y_delta} <- Map.fetch!(instruction, direction) do
      %{robot | position: {x + x_delta, y + y_delta}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
