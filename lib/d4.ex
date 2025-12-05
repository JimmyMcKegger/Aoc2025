defmodule Aoc2025.D4 do
  def p1(file \\ "inputs/d4.txt") do
    grid =
      Aoc2025.Utils.read_file(file)
      |> to_grid()

    rows = Arrays.size(grid)
    cols = Arrays.size(Arrays.get(grid, 0))

    for r <- 0..(rows - 1),
        c <- 0..(cols - 1),
        get_cell(grid, r, c) == "@" do
      count_neighbors(grid, r, c, rows, cols)
    end
    |> Enum.count(fn neighbors -> neighbors < 4 end)
  end

  defp count_neighbors(grid, r, c, rows, cols) do
    [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]
    |> Enum.count(fn {dr, dc} ->
      is_neighbor?(grid, r + dr, c + dc, rows, cols)
    end)
  end

  defp is_neighbor?(grid, r, c, rows, cols)
       when r >= 0 and r < rows and c >= 0 and c < cols do
    get_cell(grid, r, c) == "@"
  end

  defp is_neighbor?(_grid, _r, _c, _rows, _cols), do: false

  defp get_cell(grid, r, c) do
    grid |> Arrays.get(r) |> Arrays.get(c)
  end

  defp to_grid(lines) do
    Enum.map(lines, fn line ->
      String.graphemes(line) |> Arrays.new()
    end)
    |> Arrays.new()
  end
end
