defmodule AoC.Day1508 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    lines(input)
    |> Enum.map(fn str ->
      {str, parse_str(str)}
    end)
    |> Enum.map(fn {orig, parsed} -> String.length(orig) - String.length(parsed) end)
    |> Enum.sum()
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_str(str) do
    {:ok, parsed} =
      Enum.reduce(String.graphemes(str), {:init, ""}, fn
        ch, {:init, acc} ->
          if ch == "\"" do
            {:char, acc}
          else
            raise "Unexpected leading character #{ch}"
          end

        ch, {:char, acc} ->
          case ch do
            "\\" -> {:escape, acc}
            "\"" -> {:ok, acc}
            _ -> {:char, acc <> ch}
          end

        ch, {:escape, acc} ->
          case ch do
            "\\" -> {:char, acc <> "\\"}
            "\"" -> {:char, acc <> "\""}
            "x" -> {:hex1, acc}
            _ -> raise "Unexpected escape character #{ch}"
          end

        ch, {:hex1, acc} ->
          {:hex2, acc, ch}

        ch, {:hex2, acc, digit1} ->
          x = List.to_string([String.to_integer(digit1 <> ch, 16)])
          {:char, acc <> x}

        ch, _ ->
          raise "Unexpected escape character #{ch}"
      end)

    parsed
  end
end
