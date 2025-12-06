defmodule Aoc2025.D6 do
  def p1(file \\ "inputs/d6.txt") do
    Aoc2025.Utils.read_file(file)
    |> to_grid()
    |> transpose()
    |> Enum.reduce(0, &calculate(&1, &2))
  end

  def calculate(array, acc) do
    len = Arrays.size(array)
    operator = array[len - 1]
    nums = Arrays.slice(array, 0, len - 1)

    acc + process(operator, nums)
  end

  defp process("*", numbers) do
    Enum.map(numbers, &String.to_integer/1)
    |> Enum.product()
  end

  defp process("+", numbers) do
    Enum.map(numbers, &String.to_integer/1)
    |> Enum.sum()
  end

  defp process(_operator, _numbers) do
    raise("Unexpected operator")
  end

  defp to_grid(lines) do
    Enum.map(lines, fn line ->
      Regex.split(~r/\s/, line, trim: true)
      |> Arrays.new()
    end)
    |> Arrays.new()
  end

  defp transpose(grid) do
    grid
    |> Arrays.to_list()
    |> Enum.map(&Arrays.to_list/1)
    |> Enum.zip_with(& &1)
    |> Enum.map(&Arrays.new/1)
    |> Arrays.new()
  end
end
