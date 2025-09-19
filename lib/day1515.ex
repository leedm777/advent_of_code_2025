defmodule AoC.Day1515 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    ingredients = input |> lines() |> Enum.map(&parse_line/1)

    mix(ingredients, 100, [0, 0, 0, 0, 0])
    |> Enum.map(fn [cap, dur, fla, tex, _] ->
      max(cap, 0) * max(dur, 0) * max(fla, 0) * max(tex, 0)
    end)
    |> Enum.max()
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    m =
      Regex.named_captures(
        ~r/^(?<name>[^:]+): capacity (?<cap>-?[0-9]+), durability (?<dur>-?[0-9]+), flavor (?<fla>-?[0-9]+), texture (?<tex>-?[0-9]+), calories (?<cal>-?[0-9]+)$/,
        line
      )

    %{
      name: m["name"],
      props: [
        String.to_integer(m["cap"]),
        String.to_integer(m["dur"]),
        String.to_integer(m["fla"]),
        String.to_integer(m["tex"]),
        String.to_integer(m["cal"])
      ]
    }
  end

  def mix([], _, _) do
    raise "should not get here"
  end

  def mix(_, 0, props) do
    [props]
  end

  def mix([next_ingredient], amount, props) do
    [Enum.zip_with(props, next_ingredient.props, fn p, n -> p + n * amount end)]
  end

  def mix([next_ingredient | rem_ingredients], amount, props) do
    for next_amount <- amount..0//-1,
        next_props =
          Enum.zip_with(props, next_ingredient.props, fn p, n -> p + n * next_amount end),
        next_mix <- mix(rem_ingredients, amount - next_amount, next_props) do
      next_mix
    end
  end
end
