Benchee.run(
  %{
    "Day 2 Part 1" => fn -> Aoc2025.D2.p1() end,
    "Day 2 Part 2" => fn -> Aoc2025.D2.p2() end
  },
  warmup: 2,
  time: 5,
  save: [path: "bench/results/d2.benchee", tag: "current"],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "bench/results/d2.html"}
  ]
)
