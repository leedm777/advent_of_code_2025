defmodule AoC.Day1518 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(part, input) do
    solve(part, input, 100)
  end

  def solve(:part1, input, steps) do
    board = parse_board(input)
    {_, _, lit} = animate(board, steps, false)
    MapSet.size(lit)
  end

  def solve(:part2, input, steps) do
    board = light_corners(parse_board(input))
    {_, _, lit} = animate(board, steps, true)
    MapSet.size(lit)
  end

  def light_corners({num_rows, num_cols, lit}) do
    {num_rows, num_cols,
     MapSet.union(
       lit,
       MapSet.new([
         {0, 0},
         {num_rows - 1, 0},
         {0, num_cols - 1},
         {num_rows - 1, num_cols - 1}
       ])
     )}
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

  def animate(board, 0, _) do
    board
  end

  def animate({num_rows, num_cols, lit}, n, light_corners?) do
    next_lit =
      for row_num <- 0..(num_rows - 1),
          col_num <- 0..(num_cols - 1),
          {:ok, is_lit} = {:ok, MapSet.member?(lit, {row_num, col_num})},
          num_lit_neighbors = count_lit_neighbors(lit, row_num, col_num),
          num_lit_neighbors == 3 || (is_lit && num_lit_neighbors == 2),
          into: MapSet.new([]) do
        {row_num, col_num}
      end

    next_board =
      if light_corners? do
        light_corners({num_rows, num_cols, next_lit})
      else
        {num_rows, num_cols, next_lit}
      end

    animate(next_board, n - 1, light_corners?)
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
