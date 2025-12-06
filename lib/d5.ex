defmodule Aoc2025.D5 do
  def p1(file \\ "inputs/d5.txt") do
    [ingredient_ranges, ingredient_ids] =
      parse_ingredients(file)

    ranges = Enum.map(ingredient_ranges, &parse_range/1)
    ingredients = Enum.map(ingredient_ids, &String.to_integer/1)

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, &check_date(ingredient, &1))
    end)
  end

  def p2(file \\ "inputs/d5.txt") do
    parse_ingredients(file)
    |> List.first()
    |> Enum.map(&parse_range/1)
    |> Enum.sort_by(& &1.first)
    |> merge_ranges()
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  def merge_ranges([]), do: []
  def merge_ranges([range]), do: [range]

  def merge_ranges([first | rest]) do
    rest
    |> Enum.reduce([first], fn current, [prev | acc] ->
      if overlaps_or_adjacent?(prev, current) do
        merged = unionize(prev, current)
        [merged | acc] |> IO.inspect(label: :merging_overlap)
      else
        [current, prev | acc] |> IO.inspect(label: :merging_normal)
      end
    end)
    |> Enum.reverse()
    |> IO.inspect(label: :reversed)
  end

  defp unionize(r1, r2) do
    r1.first..max(r1.last, r2.last)
  end

  defp overlaps_or_adjacent?(r1, r2) do
    r1.last >= r2.first - 1
  end

  defp check_date(ingredient, range), do: ingredient in range

  defp parse_range(str) do
    [first, last] =
      str
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)

    first..last
  end

  defp parse_ingredients(file) do
    Aoc2025.Utils.read_file(file, "\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end
