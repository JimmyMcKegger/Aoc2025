defmodule Aoc2025.Benchmark do
  def measure(label, fun) do
    {time, result} = :timer.tc(fun)
    IO.puts("#{label}: #{time / 1_000_000}s")
    result
  end

  def compare(day_module) do
    IO.puts("\n=== Day #{day_module} ===")

    p1_result = measure("Part 1", fn -> day_module.p1() end)
    p2_result = measure("Part 2", fn -> day_module.p2() end)

    IO.puts("\nResults:")
    IO.puts("Part 1: #{p1_result}")
    IO.puts("Part 2: #{p2_result}")
  end
end
