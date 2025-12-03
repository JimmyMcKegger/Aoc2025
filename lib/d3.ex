defmodule Aoc2025.D3 do
  def p1(file \\ "inputs/d3.txt") do
    Aoc2025.Utils.read_file(file)
    |> Enum.map(&to_highest_pair(&1))
    |> Enum.sum()
    |> IO.inspect(label: :result)
  end

  def to_highest_pair(str) do
    digits = String.graphemes(str)
    len = length(digits)
    indexes = 0..(len - 1) |> Enum.into([])

    Enum.zip(digits, indexes)
    |> find_max()
  end

  def find_max(tup_list) do
    for {a, x} <- tup_list, {b, y} <- tup_list, x < y do
      "#{a}#{b}"
    end
    |> Enum.map(&String.to_integer/1)
    |> Enum.max()
  end
end
