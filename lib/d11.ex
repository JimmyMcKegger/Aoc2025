defmodule Aoc2025.D11 do
  def p1(file \\ "inputs/d11.txt") do
    g = build_graph(file)

    paths = find_all_paths(g, "you", "out")

    IO.puts("\nFound #{length(paths)} paths:")

    Enum.each(paths, fn path ->
      IO.puts("  #{Enum.join(path, " -> ")}")
    end)

    length(paths)
  end

  defp build_graph(file) do
    instructions = read(file)

    g = :digraph.new()

    Enum.each(instructions, fn {key, values} ->
      :digraph.add_vertex(g, key)

      Enum.each(values, fn value ->
        :digraph.add_vertex(g, value)
      end)
    end)

    Enum.each(instructions, fn {key, values} ->
      Enum.each(values, fn value ->
        :digraph.add_edge(g, key, value)
      end)
    end)

    g
  end

  def find_path(g, start, finish) do
    :digraph.get_path(g, start, finish)
  end

  def find_all_paths(g, start, finish) do
    find_all_paths(g, start, finish, [start], [])
  end

  # target, add path to results
  defp find_all_paths(_g, current, target, path, paths) when current == target do
    completed_path = Enum.reverse(path)
    [completed_path | paths]
  end

  # explore unvisited neighbors
  defp find_all_paths(g, current, target, path, paths) do
    neighbors = :digraph.out_neighbours(g, current)

    # DFS through each unvisited neighbor
    Enum.reject(neighbors, &(&1 in path))
    |> Enum.reduce(paths, fn neighbor, acc ->
      find_all_paths(g, neighbor, target, [neighbor | path], acc)
    end)
  end

  defp read(file) do
    Utils.read_file(file)
    |> Enum.map(fn line ->
      [key | values] = String.split(line, [":", " "], trim: true)
      {key, values}
    end)
    |> Map.new()
  end
end
