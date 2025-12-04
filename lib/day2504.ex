defmodule AoC.Day2504 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    neighbors = [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1},
    ]

    grid = Enum.map(input, &String.graphemes/1)
    for {row, row_num} <- Enum.with_index(grid),
        {ch, col_num} <- Enum.with_index(row),
        ch == "@",
        reduce: 0 do
      acc ->
        num_neighbors = neighbors |>
            Enum.map(fn {delta_r, delta_c} -> {row_num + delta_r, col_num + delta_c} end) |>
            Enum.map(fn {r, c} -> get_grid(grid, {r, c}) end) |>
            Enum.count(fn ch -> ch == "@" end)
        if num_neighbors < 4 do
          #IO.puts(:stderr, "#{row_num}, #{col_num}")
          acc + 1
        else
          acc
        end
    end
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
