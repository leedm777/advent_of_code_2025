defmodule AoC do
  @moduledoc """
  Solution runner for my Advent of Code 2025 solutions.
  """

  use Application

  @impl true
  def start(_type, _args) do
    Task.start_link(fn -> AoC.solve_all() end)
  end

  def module_exists?(atom) do
    function_exported?(atom, :__info__, 1)
  end

  def solve_all() do
    modules = for day_int <- 0..25,
      day_str = day_int |> Integer.to_string |> String.pad_leading(2, "0"),
      module = :"Elixir.AoC.Day#{day_str}",
      module_exists?(module) do
      {module, day_int}
    end

    answers = for {module, day_int} <- modules,
      # run this in series to be nice to the AoC servers
      input = fetch_input(day_int),
      task1 = Task.async(fn -> module.solve(:part1, input) end),
      task2 = Task.async(fn -> module.solve(:part2, input) end),
      t <- [{day_int, 2, task2}, {day_int, 1, task1}] do
      t
    end
    for {day_int, part, task} <- Enum.reverse(answers) do
      answer = Task.await(task)
      IO.puts("#{day_int}.#{part}: #{answer}")
    end
  end

  def fetch_input(0) do
    # hack for my day 0 testing the framework
    fetch_input(1, 2015)
  end

  def fetch_input(day, year \\ 2025) do
    filename = "./input/input-#{year}-#{day}.txt"
    case File.read(filename) do
      {:ok, input} -> input
      {:error, :enoent} ->
        input = download_input(day, year)
        File.write!(filename, input)
        input
      {:error, err} -> raise err
    end
  end

  def download_input(day, year) do
    cookie = File.read!("./.cookie.txt") |> String.trim
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    IO.puts(:stderr, "Downloading #{url}")
    res = Req.get!(url,
      headers: [{"cookie", cookie}])
    if res.status != 200 do
      raise "Failed to fetch input (#{url}): #{res.body}"
    end
    res.body
  end
end
