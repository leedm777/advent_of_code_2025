defmodule AoC.Day2504 do
  @behaviour AoC.Solution
  import AoC.Solution

  @roll_of_paper "@"
  @empty "."
  @neighbors [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]

  @impl true
  def solve(:part1, input) do
    grid = Enum.map(input, &String.graphemes/1)

    for {row, row_num} <- Enum.with_index(grid),
        {ch, col_num} <- Enum.with_index(row),
        ch == @roll_of_paper,
        reduce: 0 do
      acc ->
        num_neighbors = count_neighbors(grid, row_num, col_num)

        if num_neighbors < 4 do
          # IO.puts(:stderr, "#{row_num}, #{col_num}")
          acc + 1
        else
          acc
        end
    end
  end

  @impl true
  def solve(:part2, input) do
    grid = Enum.map(input, &String.graphemes/1)
    cnt = count_rolls(grid)
    {num_left, _} = move_all(cnt, grid)
    cnt - num_left
  end

  def count_neighbors(grid, row_num, col_num) do
    @neighbors
    |> Enum.map(fn {delta_r, delta_c} -> {row_num + delta_r, col_num + delta_c} end)
    |> Enum.map(fn {r, c} -> get_grid(grid, {r, c}) end)
    |> Enum.count(fn ch -> ch == @roll_of_paper end)
  end

  def move_all(cnt, grid) do
    #    print_grid(grid)

    next_grid =
      for {row, row_num} <- Enum.with_index(grid) do
        for {ch, col_num} <- Enum.with_index(row) do
          cond do
            ch == @empty -> @empty
            count_neighbors(grid, row_num, col_num) < 4 -> @empty
            true -> @roll_of_paper
          end
        end
      end

    next_cnt = count_rolls(next_grid)

    if cnt == next_cnt do
      {next_cnt, next_grid}
    else
      move_all(next_cnt, next_grid)
    end
  end

  def count_rolls(grid) do
    for row <- grid,
        ch <- row,
        ch == @roll_of_paper,
        reduce: 0 do
      x -> x + 1
    end
  end

  def print_grid(grid) do
    str = grid |> Enum.map(&Enum.join/1) |> Enum.join("\n")
    IO.write(:stderr, IO.ANSI.home())
    IO.puts(:stderr, str)
  end
end
