defmodule AoC.Solution do
  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: atom(), input:: [String.t()]) :: String.t()

  def nope do
    :nope
  end
end
