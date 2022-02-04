defmodule ReportGenerator.Parser do
  def parse_file(file) do
    file
    |> Stream.map(fn el -> parse_line(el) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
