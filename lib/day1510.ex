defmodule AoC.Day1510 do
  @behaviour AoC.Solution
  # import AoC.Solution

  @impl true
  def solve(:part1, input) do
    str = look_and_say_iter(String.trim(input), 40)
    String.length(str)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def look_and_say_iter(str, 0) do
    str
  end

  def look_and_say_iter(str, n) do
    look_and_say_iter(look_and_say(str), n - 1)
  end

  def look_and_say("") do
    ""
  end

  def look_and_say(str) do
    [first_char | chars] = String.graphemes(str)

    {acc, prior, cnt} =
      Enum.reduce(chars, {"", first_char, 1}, fn ch, {acc, prior, cnt} ->
        if ch == prior do
          {acc, ch, cnt + 1}
        else
          {"#{acc}#{cnt}#{prior}", ch, 1}
        end
      end)

    "#{acc}#{cnt}#{prior}"
  end
end
