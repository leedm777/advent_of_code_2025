defmodule AoC.Solution do
  @moduledoc """
  Base module for solving puzzles.
  """

  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: :part1 | :part2, input :: [String.t()]) :: String.t()

  @doc ~S"""
  Split a string into lines, handling trailing newline correctly.

  ## Examples

      iex> AoC.Solution.lines("foo\nbar")
      ["foo", "bar"]

      iex> AoC.Solution.lines("foo\nbar\n")
      ["foo", "bar"]
  """
  @spec lines(String.t()) :: [String.t()]
  def lines(input) do
    input |> String.trim() |> String.split("\n")
  end

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
end
