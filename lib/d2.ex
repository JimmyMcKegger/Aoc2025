defmodule Aoc2025.D2 do
  def p1(file \\ "inputs/d2.txt"), do: count_invalid_products(file, all_patterns: false)
  def p2(file \\ "inputs/d2.txt"), do: count_invalid_products(file, all_patterns: true)

  def count_invalid_products(file, opts) do
    Aoc2025.Utils.read_file(file, ",")
    |> Enum.reduce(0, &invalid_ids(&1, &2, opts[:all_patterns]))
  end

  def invalid_ids(range, acc, all? \\ false) do
    nums =
      to_range(range)

    invalids = Enum.filter(nums, &invalid?(&1, all?))

    acc + Enum.sum(invalids)
  end

  def invalid?(number, all_patterns?) do
    chars = Integer.to_string(number) |> String.graphemes()

    has_invalid_priduct?(chars) or
      (all_patterns? and has_repeating_pattern?(number))
  end

  defp has_invalid_priduct?(chars) do
    len = length(chars)
    rem(len, 2) == 0 and invalid_product?(chars)
  end

  def invalid_product?(chars) do
    middle = div(length(chars), 2)
    {first, second} = Enum.split(chars, middle)
    first == second
  end

  def has_repeating_pattern?(number) when number < 11, do: false

  def has_repeating_pattern?(number) do
    chars = Integer.to_string(number) |> String.graphemes()
    len = length(chars)

    Enum.any?(1..div(len, 2), fn pattern_len ->
      if rem(len, pattern_len) == 0 do
        pattern = Enum.take(chars, pattern_len)
        chunks = Enum.chunk_every(chars, pattern_len)
        Enum.all?(chunks, fn chunk -> chunk == pattern end)
      else
        false
      end
    end)
  end

  def to_range(str) do
    [n, m] =
      String.replace(str, "\n", "")
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)

    Range.new(n, m)
  end
end
