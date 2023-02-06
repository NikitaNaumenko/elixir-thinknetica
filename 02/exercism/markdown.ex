defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> enclose_list
  end

  defp process("#" <> _ = line), do: line |> parse_header
  defp process("*" <> _ = line), do: line |> parse_list
  defp process(line), do: line |> parse_paragraph

  defp parse_header(line) do
    [octothorpes | words] = String.split(line)
    level = String.length(octothorpes)
    text = Enum.join(words, " ")
    "<h#{level}>#{text}</h#{level}>"
  end

  defp parse_list(line) do
    text =
      line
      |> String.trim_leading("* ")
      |> String.split()
      |> Enum.map_join(" ", &replace_md_with_tag/1)

    "<li>#{text}</li>"
  end

  defp parse_paragraph(line) do
    text =
      line
      |> String.split()
      |> Enum.map_join(" ", &replace_md_with_tag/1)

    "<p>#{text}</p>"
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix
    |> replace_suffix
  end

  defp replace_prefix(word) do
    strong = ~r/^#{"__"}{1}/
    em = ~r/^[#{"_"}{1}][^#{"_"}+]/

    cond do
      word =~ strong -> String.replace(word, strong, "<strong>", global: false)
      word =~ em -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix(word) do
    strong = ~r/#{"__"}{1}$/
    em = ~r/[^#{"_"}{1}]/

    cond do
      word =~ strong -> String.replace(word, strong, "</strong>")
      word =~ em -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp enclose_list(text) do
    text
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
