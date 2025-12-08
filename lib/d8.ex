defmodule Aoc2025.D8 do
  def p1(file \\ "inputs/d8.txt", num_connections \\ 1000) do
    boxes = junction_boxes(file)

    edges =
      for {box, i} <- Enum.with_index(boxes),
          {other, j} <- Enum.with_index(boxes),
          i < j do
        {distance(box, other), i, j}
      end
      |> Enum.sort()
      |> IO.inspect(label: :edges)

    edges_to_connect = Enum.take(edges, num_connections)

    g = :digraph.new([:cyclic])

    Enum.each(0..(length(boxes) - 1), fn i ->
      :digraph.add_vertex(g, i)
    end)

    Enum.each(edges_to_connect, fn {_dist, i, j} ->
      :digraph.add_edge(g, i, j)
      :digraph.add_edge(g, j, i)
    end)

    circuits =
      :digraph_utils.strong_components(g) |> IO.inspect(label: :components, charlists: :as_lists)

    circuit_sizes =
      circuits
      |> Enum.map(&length/1)
      |> Enum.sort(:desc)
      |> IO.inspect(label: :circuit_sizes)

    IO.inspect(circuit_sizes, label: :circuit_sizes)

    circuit_sizes
    |> Enum.take(3)
    |> Enum.product()
  end

  def distance({p1, p2, p3}, {q1, q2, q3}) do
    :math.sqrt(:math.pow(p1 - q1, 2) + :math.pow(p2 - q2, 2) + :math.pow(p3 - q3, 2))
  end

  defp junction_boxes(file) do
    Utils.read_file(file)
    |> Enum.map(fn box ->
      String.split(box, ",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
