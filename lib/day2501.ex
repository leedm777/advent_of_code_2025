defmodule AoC.Day2501 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    decode_password(input, 50, 0)
  end

  @impl true
  def solve(:part2, input) do
    decode_password2(Enum.map(input, &parse_rotation/1), 50, 0)
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

  def decode_password2([], _ptr, ctr) do
    ctr
  end

  def decode_password2([next | rest], 0, ctr) do
    next_ptr = Integer.mod(next, 100)
    full_turns = abs(div(next, 100))
    next_ctr = ctr + full_turns
    # IO.puts(:stderr, "#{next} => #{next_ptr}, #{next_ctr}")
    decode_password2(rest, next_ptr, next_ctr)
  end

  def decode_password2([next | rest], ptr, ctr) do
    next_ptr = Integer.mod(ptr + next, 100)
    full_turns = abs(div(next, 100))

    extra =
      if next_ptr == 0 || (next < 0 && next_ptr > ptr) || (next > 0 && next_ptr < ptr),
        do: 1,
        else: 0

    next_ctr = ctr + full_turns + extra
    # IO.puts(:stderr, "#{next} => #{next_ptr}, #{next_ctr}")
    decode_password2(rest, next_ptr, next_ctr)
  end

  def parse_rotation(str) do
    dir = String.first(str)
    abs_steps = String.to_integer(String.slice(str, 1..100))
    if dir == "R", do: abs_steps, else: -abs_steps
  end
end
