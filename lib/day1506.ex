defmodule AoC.Day1506 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    grid =
      for row <- 0..999, col <- 0..999, into: %{} do
        {{row, col}, false}
      end

    lines(input)
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(grid, fn %{
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
  def solve(:part2, input) do
    bright_grid =
      for row <- 0..999, col <- 0..999, into: %{} do
        {{row, col}, 0}
      end

    lines(input)
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(bright_grid, fn %{
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
            "turn on" -> acc[{row, col}] + 1
            "turn off" -> max(acc[{row, col}] - 1, 0)
            "toggle" -> acc[{row, col}] + 2
          end

        {{row, col}, v}
      end
    end)
    |> Enum.sum_by(fn {_, v} -> v end)
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
