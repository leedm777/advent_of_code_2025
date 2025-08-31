defmodule AoC.Solution do
  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: atom(), input :: [String.t()]) :: String.t()

  def lines(input) do
    input |> String.trim() |> String.split("\n")
  end
end
