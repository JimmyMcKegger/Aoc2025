defmodule Aoc2025 do
  use Rustler, otp_app: :aoc2025, crate: "aoc2025"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
