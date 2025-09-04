defmodule AoC.Day1506 do
  @behaviour AoC.Solution
  import AoC.Solution

  @grid (for row <- 0..999, col <- 0..999, into: %{} do
           {{row, col}, false}
         end)

  @impl true
  def solve(:part1, input) do
    lines(input)
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(@grid, fn %{
                               cmd: cmd,
                               start_row: start_row,
                               start_col: start_col,
                               end_row: end_row,
                               end_col: end_col
                             },
                             acc ->
      for row <- start_row..end_row, col <- start_col..end_col, into: acc do
        v =
          case cmd do
            "turn on" -> true
            "turn off" -> false
            "toggle" -> !acc[{row, col}]
          end

        {{row, col}, v}
      end
    end)
    |> Enum.count(fn {_, v} -> v end)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    strs =
      Regex.named_captures(
        ~r/^(?<cmd>toggle|turn on|turn off) (?<start_row>\d+),(?<start_col>\d+) through (?<end_row>\d+),(?<end_col>\d+)$/,
        line
      )

    %{
      cmd: strs["cmd"],
      start_row: String.to_integer(strs["start_row"]),
      start_col: String.to_integer(strs["start_col"]),
      end_row: String.to_integer(strs["end_row"]),
      end_col: String.to_integer(strs["end_col"])
    }
  end
end
