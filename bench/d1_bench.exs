Benchee.run(
  %{
    "Day 1 Part 1" => fn -> Aoc2025.D1.p1() end,
    "Day 1 Part 2" => fn -> Aoc2025.D1.p2() end
  },
  warmup: 2,
  time: 5,
  save: [path: "bench/results/d1.benchee", tag: "current"],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "bench/results/d1.html"}
  ]
)
