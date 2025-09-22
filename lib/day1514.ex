defmodule AoC.Day1514 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 2503)
  end

  @impl true
  def solve(:part2, input) do
    solve(:part2, input, 2503)
  end

  def solve(:part1, input, flight_time) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(&distance_flown(&1, flight_time))
    |> Enum.max()
  end

  def solve(:part2, input, flight_time) do
    deer = Enum.map(input, &parse_line/1)

    scores = Enum.map(deer, &{&1.name, 0})

    points_race(0, flight_time, scores, deer)
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

  def points_race(time_flown, flight_goal, scores, _) when time_flown == flight_goal do
    scores |> Enum.map(&elem(&1, 1)) |> Enum.max()
  end

  def points_race(time_flown, flight_goal, scores, deer) do
    distances = Enum.map(deer, fn d -> {d.name, distance_flown(d, time_flown + 1)} end)
    max_distance = distances |> Enum.map(&elem(&1, 1)) |> Enum.max()

    scores_points =
      distances
      |> Enum.filter(fn {_, dist} -> dist == max_distance end)
      |> Enum.map(&elem(&1, 0))
      |> MapSet.new()

    scores =
      Enum.map(scores, fn {name, score} ->
        if MapSet.member?(scores_points, name) do
          {name, score + 1}
        else
          {name, score}
        end
      end)

    points_race(time_flown + 1, flight_goal, scores, deer)
  end
end
