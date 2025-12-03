defmodule Aoc2025.Utils do
  def read_file(path, splitter \\ "\n") do
    File.read!(path)
    |> String.split(splitter, trim: true)
  end
end
