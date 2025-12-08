Benchee.run(
  %{
    "Day 7 Part 1" => fn -> Aoc2025.D7.p1() end,
    "Day 7 Part 2" => fn -> Aoc2025.D7.p2() end
  },
  warmup: 2,
  time: 5,
  load: "bench/results/d7.benchee",
  save: [path: "bench/results/d7.benchee"],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "bench/results/d7.html"}
  ]
)
