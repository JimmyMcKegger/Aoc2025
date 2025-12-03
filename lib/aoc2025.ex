defmodule Aoc2025 do
  use Rustler, otp_app: :aoc2025, crate: "aoc2025"

  # When your NIF is loaded, it will override these functions.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def invalid_product(_number), do: :erlang.nif_error(:nif_not_loaded)
  def has_repeating_pattern(_number), do: :erlang.nif_error(:nif_not_loaded)
end
