defmodule AoC do
  @moduledoc """
  Solution runner for my Advent of Code 2025 solutions.
  """

  use Application

  @impl true
  def start(_type, _args) do
    solve? = Application.get_env(:aoc, :solve)

    children = [
      {AoC.Input, name: AoC.Input},
      {Task, fn -> AoC.solve_all(solve?) end}
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end

  def module_exists?(atom) do
    function_exported?(atom, :__info__, 1)
  end

  def solve_all(false) do
  end

  def solve_all(true) do
    {:ok, all_aoc_modules} = :application.get_key(:aoc, :modules)

    modules =
      all_aoc_modules
      |> Enum.filter(fn module -> String.match?(Atom.to_string(module), ~r/\.Day[0-9]+$/) end)
      |> Enum.map(fn module ->
        %{"year" => year, "day" => day} =
          Regex.named_captures(
            ~r/Day(?<year>[0-9][0-9])?(?<day>[0-9][0-9])$/,
            Atom.to_string(module)
          )

        {module, "20#{year}", day}
      end)

    answers =
      for {module, year, day} <- modules,
          # run this in series to be nice to the AoC servers
          input = fetch_input(year, day),
          task1 = Task.async(fn -> module.solve(:part1, input) end),
          task2 = Task.async(fn -> module.solve(:part2, input) end),
          t <- [{year, day, 1, task1}, {year, day, 2, task2}] do
        t
      end

    for {year, day, part, task} <- answers do
      answer = Task.await(task, :infinity)
      IO.puts("#{year}-#{day}.#{part}: #{answer}")
    end
  end

  @doc """
  Fetch the input for a given year and day.
  """
  @spec fetch_input(integer, integer) :: [String.t()]
  def fetch_input(year, day) do
    GenServer.call(AoC.Input, {:fetch, year, day}) |> lines()
  end

  @doc ~S"""
  Split a string into lines, handling trailing newline correctly.

  ## Examples

  iex> AoC.lines("foo\nbar")
  ["foo", "bar"]

  iex> AoC.lines("foo\nbar\n")
  ["foo", "bar"]
  """
  @spec lines(String.t()) :: [String.t()]
  def lines(input) do
    input |> String.trim() |> String.split("\n")
  end
end
