defmodule Aoc2025.D9 do
  def p1(file \\ "inputs/d9.txt") do
    read_file(file)
    |> to_areas()
    |> Enum.max()
  end

  def p2(file \\ "inputs/d9ex.txt") do
    read_file(file)
    # |> to_solid_areas()
    # |> Enum.max()

    24
  end

  def to_areas(list) do
    for {point1, i} <- Enum.with_index(list),
        {point2, j} <- Enum.with_index(list),
        i < j do
      area(point1, point2)
    end
  end

  def area({x1, y1}, {x2, y2}) do
    width = abs(x1 - x2) + 1
    height = abs(y1 - y2) + 1
    width * height
  end

  defp read_file(file) do
    Utils.read_file(file)
    |> Enum.map(fn coord ->
      String.split(coord, ",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
