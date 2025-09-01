defmodule AoC.Solution do
  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: atom(), input :: [String.t()]) :: String.t()

  def lines(input) do
    input |> String.trim() |> String.split("\n")
  end

  def move({row, col}, dir) do
    case dir do
      ">" -> {row, col + 1}
      "v" -> {row + 1, col}
      "<" -> {row, col - 1}
      "^" -> {row - 1, col}
    end
  end
end
