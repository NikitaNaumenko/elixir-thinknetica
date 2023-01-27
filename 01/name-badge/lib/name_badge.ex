defmodule NameBadge do
  def print(id, name, department) do
    formatted_id = if id, do: "[#{id}]", else: nil
    formatted_department = if department, do: String.upcase(department), else: 'OWNER'

    [formatted_id, name, formatted_department]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(" - ")
  end
end
