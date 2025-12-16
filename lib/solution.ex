defmodule AoC.Solution do
  @moduledoc """
  Base module for solving puzzles.
  """

  @doc """
  Solve a puzzle.
  """
  @callback solve(part :: :part1 | :part2, input :: [String.t()]) :: integer() | String.t()

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

  def get_grid(grid, {row, col}, void_ch \\ ".") do
    cond do
      row < 0 -> void_ch
      col < 0 -> void_ch
      row >= length(grid) -> void_ch
      col >= length(Enum.at(grid, 0)) -> void_ch
      true -> grid |> Enum.at(row) |> Enum.at(col)
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

  # @spec find_path(
  #         T,
  #         (T -> boolean()),
  #         (T -> list({integer(), T})),
  #         (T -> integer())
  #       ) :: list(T)
  #       when T: var
  def find_path(start, is_goal, get_neighbors, h) do
    open = [{h.(start), start}] |> Enum.into(PriorityQueue.new())
    came_from = Map.new()

    find_path_n(is_goal, get_neighbors, h, open, came_from, %{start => 0})
  end

  # @spec find_path_n(
  #         (T -> boolean()),
  #         (T -> list({integer(), T})),
  #         (T -> integer()),
  #         PriorityQueue.t(),
  #         %{T => T},
  #         %{T => integer}
  #       ) :: list(T)
  #       when T: var
  def find_path_n(is_goal, get_neighbors, h, open, came_from, cost) do
    case PriorityQueue.pop(open, {:empty, nil}) do
      {{:empty, _}, _} ->
        nil

      {{_prio, current}, next_open} ->
        # IO.puts(
        #   :stderr,
        #   "#{inspect({current, PriorityQueue.to_list(next_open)}, charlists: :as_lists)} (#{prio})"
        # )

        if is_goal.(current) do
          path_to(came_from, current)
          # |> tap(&IO.puts(:stderr, "  " <> inspect(&1, charlists: :as_lists)))
        else
          current_cost = Map.get(cost, current)

          {next_open, next_came_from, next_cost} =
            get_neighbors.(current)
            # |> tap(&IO.puts(:stderr, "  #{inspect(&1)}"))
            |> Enum.reduce(
              {next_open, came_from, cost},
              fn {step_cost, neighbor}, {next_open, next_came_from, next_cost} ->
                cost_to_neighbor = current_cost + step_cost

                if cost_to_neighbor < Map.get(next_cost, neighbor, :infinity) do
                  # new path to the neighbor
                  f = cost_to_neighbor + h.(neighbor)

                  {
                    PriorityQueue.put(next_open, f, neighbor),
                    Map.put(next_came_from, neighbor, current),
                    Map.put(next_cost, neighbor, cost_to_neighbor)
                  }
                else
                  {next_open, next_came_from, next_cost}
                end
              end
            )

          find_path_n(is_goal, get_neighbors, h, next_open, next_came_from, next_cost)
        end
    end
  end

  @spec path_to(%{T => T}, T) :: list(T) when T: var
  def path_to(came_from, node) do
    case Map.get(came_from, node) do
      nil -> [node]
      prior -> [node | path_to(came_from, prior)]
    end
  end
end
