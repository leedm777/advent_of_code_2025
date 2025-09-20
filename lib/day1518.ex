defmodule AoC.Day1518 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 100)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def solve(:part1, input, steps) do
    board = parse_board(input)
    {_, _, lit} = animate(board, steps)
    MapSet.size(lit)
  end

  def parse_board(input) do
    lns = Enum.with_index(lines(input))

    lit =
      for {row, row_num} <- lns,
          {ch, col_num} <- Enum.with_index(String.graphemes(row)),
          ch == "#",
          into: MapSet.new([]) do
        {row_num, col_num}
      end

    num_rows = length(lns)
    num_cols = String.length(elem(hd(lns), 0))
    {num_rows, num_cols, lit}
  end

  def animate(board, 0) do
    board
  end

  def animate({num_rows, num_cols, lit}, n) do
    next_lit =
      for row_num <- 0..(num_rows - 1),
          col_num <- 0..(num_cols - 1),
          {:ok, is_lit} = {:ok, MapSet.member?(lit, {row_num, col_num})},
          num_lit_neighbors = count_lit_neighbors(lit, row_num, col_num),
          num_lit_neighbors == 3 || (is_lit && num_lit_neighbors == 2),
          into: MapSet.new([]) do
        {row_num, col_num}
      end

    animate({num_rows, num_cols, next_lit}, n - 1)
  end

  def count_lit_neighbors(lit, row_num, col_num) do
    for r <- (row_num - 1)..(row_num + 1),
        c <- (col_num - 1)..(col_num + 1),
        !(r == row_num && c == col_num),
        MapSet.member?(lit, {r, c}),
        reduce: 0 do
      acc -> acc + 1
    end
  end
end
