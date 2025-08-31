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
          t <- [{year, day, 2, task2}, {year, day, 1, task1}] do
        t
      end

    for {year, day, part, task} <- Enum.reverse(answers) do
      answer = Task.await(task)
      IO.puts("#{year}-#{day}.#{part}: #{answer}")
    end
  end

  def fetch_input(year, day) do
    filename = "./input/input-#{year}-#{day}.txt"

    case File.read(filename) do
      {:ok, input} ->
        input

      {:error, :enoent} ->
        input = download_input(year, day)
        File.write!(filename, input)
        input

      {:error, err} ->
        raise err
    end
  end

  def download_input(year, day) do
    case File.read("./.cookie.txt") do
      {:ok, cookie} ->
        cookie = String.trim(cookie)
        url = get_url(year, day)
        IO.puts(:stderr, "Downloading #{url}")

        case Req.get(url, headers: [{"cookie", cookie}]) do
          {:ok, res} ->
            if res.status != 200 do
              raise "Failed to fetch input (#{url}): #{res.body}"
            end

            res.body

          {:error, ex} ->
            IO.puts(:stderr, "Failed to fetch input (#{url}): #{inspect(ex)}")
            raise ex
        end

      {:error, :enoent} ->
        raise ".cookie.txt does not exist; see README.md"

      {:error, err} ->
        raise err
    end
  end

  def get_url(year, "0" <> day) do
    get_url(year, day)
  end

  def get_url(year, day) do
    "https://adventofcode.com/#{year}/day/#{day}/input"
  end
end
