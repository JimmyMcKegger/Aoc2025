defmodule Aoc2025.D3 do
  require IEx

  @needed 12

  def p1(file \\ "inputs/d3.txt") do
    Aoc2025.Utils.read_file(file)
    |> Enum.map(&to_highest_pair(&1))
    |> Enum.sum()
  end

  def p2(file \\ "inputs/d3.txt") do
    Aoc2025.Utils.read_file(file)
    |> Enum.map(&to_highest_dozen(&1))
    |> Enum.sum()
  end

  def to_highest_pair(str) do
    digits = String.graphemes(str)
    len = length(digits)
    indexes = 0..(len - 1) |> Enum.into([])

    Enum.zip(digits, indexes)
    |> find_max_pair()
  end

  def find_max_pair(tup_list) do
    for {a, x} <- tup_list, {b, y} <- tup_list, x < y do
      "#{a}#{b}"
    end
    |> Enum.map(&String.to_integer/1)
    |> Enum.max()
  end

  def to_highest_dozen(str) do
    digits = String.graphemes(str)
    total = length(digits)

    digits
    |> Enum.with_index()
    |> Enum.reduce([], fn {digit, idx}, stack ->
      digits_remaining = total - idx - 1

      stack = pop_smaller_digits(stack, digit, length(stack), digits_remaining)

      if length(stack) < @needed do
        stack ++ [digit]
      else
        stack
      end
    end)
    |> Enum.join()
    |> String.to_integer()
  end

  defp pop_smaller_digits([], _digit, _stack_len, _remaining), do: []

  defp pop_smaller_digits(stack, digit, stack_len, remaining) do
    can_afford? = stack_len - 1 + remaining + 1 >= @needed

    if can_afford? and List.last(stack) < digit do
      new_stack = List.delete_at(stack, -1)
      pop_smaller_digits(new_stack, digit, stack_len - 1, remaining)
    else
      stack
    end
  end
end
