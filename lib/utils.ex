defmodule Utils do
  def read_file(path, splitter \\ "\n") do
    File.read!(path)
    |> String.split(splitter, trim: true)
  end

  def to_grid(lines) do
    Enum.map(lines, fn line ->
      String.graphemes(line) |> Arrays.new()
    end)
    |> Arrays.new()
  end
end
