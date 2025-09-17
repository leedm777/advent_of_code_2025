defmodule AoC.Day1514 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 2503)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def solve(:part1, input, flight_time) do
    input
    |> lines()
    |> Enum.map(&parse_line/1)
    |> Enum.map(&distance_flown(&1, flight_time))
    |> Enum.max()
  end

  def parse_line(line) do
    m =
      Regex.named_captures(
        ~r/^(?<name>[A-Za-z]+) can fly (?<speed>[0-9]+) km\/s for (?<duration>[0-9]+) seconds, but then must rest for (?<rest>[0-9]+) seconds\.$/,
        line
      )

    %{
      name: m["name"],
      speed: String.to_integer(m["speed"]),
      duration: String.to_integer(m["duration"]),
      rest: String.to_integer(m["rest"])
    }
  end

  def distance_flown(deer, flight_time) do
    %{speed: speed, duration: duration, rest: rest} = deer
    num_laps = Integer.floor_div(flight_time, duration + rest)
    partial_time = min(duration, flight_time - num_laps * (duration + rest))

    speed * (num_laps * duration + partial_time)
  end
end
