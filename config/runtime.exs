import Config

if IEx.started?() do
  IO.puts(:stderr, "Skipping solves in iex")
  config :aoc, solve: false
end
