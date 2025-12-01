defmodule AoC.Day2501 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    decode_password(input, 50, 0)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def decode_password([], _ptr, ctr) do
    ctr
  end

  def decode_password([next | rest], ptr, ctr) do
    dir = String.first(next)
    abs_steps = String.to_integer(String.slice(next, 1..100))
    clicks = if dir == "R", do: abs_steps, else: -abs_steps
    next_ptr = rem(ptr + clicks + 100, 100)
    next_ctr = if next_ptr == 0, do: ctr + 1, else: ctr

    # IO.puts(:stderr, "#{next} => #{next_ptr}, #{next_ctr}")
    decode_password(rest, next_ptr, next_ctr)
  end
end
