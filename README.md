# Aoc2025

**Solutions for [Advent of Code 2025](https://adventofcode.com/2025)**

## Running Solutions

Run individual days in IEx:

```elixir
iex -S mix
iex> Aoc2025.D2.p1()   # Run part 1 of day 2
iex> Aoc2025.D2.p2()   # Run part 2 of day 2
```


## Benchmarking

Install benchee:

```elixir
mix deps.get
```

Run benchmarks for a specific day:

```bash
mix run bench/d2_bench.exs
```

This saves results to `bench/results/d2.benchee`.

Then view the report:

```bash
open bench/results/d2.html
```

### Comparing Performance

The `.benchee` files in `bench/results/` store benchmark data. You can compare against previous runs:

```elixir
# In bench/d2_bench.exs
Benchee.run(
  %{
    "Day 2 Part 1" => fn -> Aoc2025.D2.p1() end,
    "Day 2 Part 2" => fn -> Aoc2025.D2.p2() end
  },
  load: "bench/results/d2.benchee",  # Compare with previous
  save: [path: "bench/results/d2.benchee", tag: "current"]
)
```

### Manual Regression Checking

Compare current performance to a previous run by loading the old `.benchee` file:

```elixir
Benchee.run(
  %{"Day 2 Part 1" => fn -> Aoc2025.D2.p1() end},
  load: "bench/results/d2.benchee",
  save: [path: "bench/results/d2.benchee", tag: "after-refactor"]
)
```

Benchee will show comparisons automatically when loading previous results.

## Rust NIFs

Some solutions use Rust NIFs via Rustler for better performance. The Rust code is in `native/aoc2025/`.

Make sure you have Rust 1.91+ installed:

```bash
rustc --version
rustup update
```
