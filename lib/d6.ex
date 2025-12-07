defmodule Aoc2025.D6 do
  def p1(file \\ "inputs/d6.txt") do
    Utils.read_file(file)
    |> to_grid()
    |> transpose()
    |> Enum.reduce(0, &calculate(&1, &2))
  end

  def p2(file \\ "inputs/d6.txt") do
    Utils.read_file(file)
    |> parse_by_char_cols()
    |> Enum.reduce(0, &calculate_properly(&1, &2))
  end

  defp calculate_properly({operator, digit_columns}, acc) do
    numbers =
      Enum.map(digit_columns, fn column ->
        column
        |> Enum.drop(-1)
        |> Enum.join()
        |> String.trim()
        |> then(fn str ->
          if str == "", do: 0, else: String.to_integer(str)
        end)
      end)

    result = process_properly(operator, numbers)
    acc + result
  end

  defp process_properly("+", nums) do
    Enum.sum(nums)
  end

  defp process_properly("*", nums) do
    Enum.product(nums)
  end

  defp calculate(array, acc) do
    len = Arrays.size(array)
    operator = array[len - 1]
    nums = Arrays.slice(array, 0, len - 1)

    acc + process(operator, nums)
  end

  defp process("*", numbers) do
    Enum.map(numbers, &String.to_integer/1)
    |> Enum.product()
  end

  defp process("+", numbers) do
    Enum.map(numbers, &String.to_integer/1)
    |> Enum.sum()
  end

  defp to_grid(lines) do
    Enum.map(lines, fn line ->
      Regex.split(~r/\s/, line, trim: true)
      |> Arrays.new()
    end)
    |> Arrays.new()
  end

  defp parse_by_char_cols(lines) do
    lines
    |> Enum.map(&String.graphemes/1)
    |> transpose_chars()
    |> split_into_problems()
  end

  defp transpose_chars(rows) do
    max_len = Enum.map(rows, &length/1) |> Enum.max()
    padded = Enum.map(rows, fn row -> row ++ List.duplicate(" ", max_len - length(row)) end)

    Enum.zip_with(padded, & &1)
  end

  defp split_into_problems(char_columns) do
    char_columns
    |> Enum.chunk_by(fn column ->
      Enum.all?(column, &(&1 == " "))
    end)
    |> Enum.reject(fn chunk ->
      case chunk do
        [first_col | _] -> Enum.all?(first_col, &(&1 == " "))
        [] -> true
      end
    end)
    |> Enum.map(fn problem_columns ->
      operator = problem_columns |> hd() |> List.last()
      {operator, problem_columns}
    end)
  end

  defp transpose(grid) do
    grid
    |> Arrays.to_list()
    |> Enum.map(&Arrays.to_list/1)
    |> Enum.zip_with(& &1)
    |> Enum.map(&Arrays.new/1)
    |> Arrays.new()
  end
end
