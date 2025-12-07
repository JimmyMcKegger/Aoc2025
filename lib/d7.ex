defmodule Aoc2025.D7 do
  @splitter "^"

  def p1(file \\ "inputs/d7.txt") do
    # tachyon manifold
    diagram = parse_input(file)

    start = diagram[0] |> Enum.find_index(&(&1 == "S"))

    %{count: 0, beam_indexes: MapSet.new([start])}
    |> fire_beam(diagram, 1, Arrays.size(diagram))
    |> Map.get(:count)
  end

  def p2(file \\ "inputs/d7.txt") do
    # quantum tachyon manifold
    diagram = parse_input(file)

    start = diagram[0] |> Enum.find_index(&(&1 == "S"))

    fire_quantum_beam(%{start => 1}, diagram, 1, Arrays.size(diagram))
    |> Map.values()
    |> Enum.sum()
  end

  def fire_quantum_beam(tracker, _diagram, next, stop) when next == stop, do: tracker

  def fire_quantum_beam(tracker, diagram, next, stop) do
    current_line = diagram[next]

    if Enum.any?(current_line, &(&1 == @splitter)) do
      new_tracker =
        Enum.reduce(tracker, %{}, fn {pos, timeline_count}, acc ->
          if current_line[pos] == @splitter do
            acc
            |> Map.update(pos - 1, timeline_count, &(&1 + timeline_count))
            |> Map.update(pos + 1, timeline_count, &(&1 + timeline_count))
          else
            Map.update(acc, pos, timeline_count, &(&1 + timeline_count))
          end
        end)

      fire_quantum_beam(
        new_tracker,
        diagram,
        next + 1,
        stop
      )
    else
      fire_quantum_beam(tracker, diagram, next + 1, stop)
    end
  end

  def fire_beam(tracker, _diagram, next, stop) when next == stop, do: tracker

  def fire_beam(tracker, diagram, next, stop) do
    current_line = diagram[next]

    if Enum.any?(current_line, &(&1 == @splitter)) do
      beams = tracker.beam_indexes

      results =
        for b <- beams do
          if current_line[b] == @splitter do
            {[b - 1, b + 1], 1}
          else
            {[b], 0}
          end
        end

      {new_indexes, new_count} =
        Enum.reduce(results, {[], 0}, fn {list, counter}, acc ->
          {elem(acc, 0) ++ list, elem(acc, 1) + counter}
        end)

      fire_beam(
        %{beam_indexes: MapSet.new(new_indexes), count: tracker.count + new_count},
        diagram,
        next + 1,
        stop
      )
    else
      fire_beam(tracker, diagram, next + 1, stop)
    end
  end

  defp parse_input(file) do
    Utils.read_file(file)
    |> Utils.to_grid()
  end
end
