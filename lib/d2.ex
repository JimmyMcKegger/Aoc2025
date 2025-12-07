defmodule Aoc2025.D2 do
  def p1(file \\ "inputs/d2.txt"), do: count_products(file, all_patterns: false)
  def p2(file \\ "inputs/d2.txt"), do: count_products(file, all_patterns: true)

  def count_products(file, opts) do
    Utils.read_file(file, ",")
    |> Enum.reduce(0, &invalid_ids(&1, &2, opts[:all_patterns]))
  end

  def invalid_ids(range, acc, all? \\ false) do
    nums =
      to_range(range)

    invalids = Enum.filter(nums, &invalid?(&1, all?))

    acc + Enum.sum(invalids)
  end

  def invalid?(number, all_patterns?) do
    Aoc2025.invalid_product(number) or
      (all_patterns? and Aoc2025.has_repeating_pattern(number))
  end

  def invalid_product?(chars) do
    middle = div(length(chars), 2)
    {first, second} = Enum.split(chars, middle)

    first == second
  end

  def to_range(str) do
    [n, m] =
      String.replace(str, "\n", "")
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)

    Range.new(n, m)
  end
end
