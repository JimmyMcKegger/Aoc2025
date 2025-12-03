defmodule Aoc2025.D1 do
  import Aoc2025.Utils

  @start 50

  def p1(file \\ "inputs/d1.txt") do
    read_file(file)
    |> Enum.reduce({@start, 0}, &dial(&1, &2))
    |> elem(1)
  end

  def p2(file \\ "inputs/d1.txt") do
    read_file(file)
    |> Enum.reduce({@start, 0}, &dial(&1, &2, true))
    |> elem(1)
  end

  def dial(str, acc, all \\ false) do
    res =
      Regex.named_captures(~r/(?<dir>[RL])(?<num>\d+)/, str)

    turn(res, acc, all)
  end

  def turn(%{"dir" => dir, "num" => n}, {position, count}, count_all_passes?) do
    n = String.to_integer(n)

    if count_all_passes? do
      move_and_count(dir, position, n, count)
    else
      new_pos = calculate_position(dir, position, n)
      {new_pos, count + if(new_pos == 0, do: 1, else: 0)}
    end
  end

  defp move_and_count(_dir, position, 0, count), do: {position, count}

  defp move_and_count(dir, position, steps, count) do
    new_pos = calculate_position(dir, position, 1)
    new_count = count + if(new_pos == 0, do: 1, else: 0)

    move_and_count(dir, new_pos, steps - 1, new_count)
  end

  defp calculate_position("R", position, n) do
    rem(position + n, 100)
  end

  defp calculate_position("L", position, n) do
    rem(position - rem(n, 100) + 100, 100)
  end
end
