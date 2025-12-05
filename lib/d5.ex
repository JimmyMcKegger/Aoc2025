defmodule Aoc2025.D5 do
  def p1(file \\ "inputs/d5.txt") do
    [ingredient_ranges, ingredient_ids] =
      Aoc2025.Utils.read_file(file, "\n\n")
      |> Enum.map(&String.split(&1, "\n", trim: true))

    ranges = Enum.map(ingredient_ranges, &parse_range/1)
    ingredients = Enum.map(ingredient_ids, &String.to_integer/1)

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, &check_date(ingredient, &1))
    end)
  end

  def p2(file \\ "inputs/d5.txt") do
    [ingredient_ranges, _ingredient_ids] =
      Aoc2025.Utils.read_file(file, "\n\n")
      |> Enum.map(&String.split(&1, "\n", trim: true))

    acc = MapSet.new([])

    Enum.map(ingredient_ranges, &parse_range/1)
    |> Enum.reduce(acc, &merge_ranges/2)
    |> MapSet.size()
  end

  def merge_ranges(range, acc) do
    range
    |> MapSet.new()
    |> MapSet.union(acc)
  end

  defp check_date(ingredient, range), do: ingredient in range

  defp parse_range(str) do
    [first, last] =
      str
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)

    first..last
  end
end
