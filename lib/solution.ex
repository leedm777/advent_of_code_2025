defmodule AoC.Solution do
  @moduledoc """
  Base module for solving puzzles.
  """

  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: :part1 | :part2, input :: [String.t()]) :: String.t()

  @typedoc """
  A two-dimensional integer position. Given as `{row, col}`.
  """
  @type pos() :: {row :: integer, col :: integer}

  @doc """
  Move a position by one in the given direction.
  """
  @spec move(pos :: pos(), dir :: String.t()) :: pos()
  def move({row, col}, dir) do
    case dir do
      ">" -> {row, col + 1}
      "v" -> {row + 1, col}
      "<" -> {row, col - 1}
      "^" -> {row - 1, col}
    end
  end

  @spec permutations(lst :: list(any())) :: list(list(any()))
  def permutations([]) do
    [[]]
  end

  def permutations(lst) do
    for item <- lst,
        rest <- permutations(lst -- [item]) do
      [item | rest]
    end
  end

  @spec circular_permutations(lst :: list(any())) :: list(list(any()))
  def circular_permutations([]) do
    []
  end

  def circular_permutations(lst) do
    [head | rest] = lst
    rest |> permutations() |> Enum.map(&[head | &1])
  end

  def now_str() do
    Timex.format!(Timex.local(), "{ISO:Extended}")
  end
end
