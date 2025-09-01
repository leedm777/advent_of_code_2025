defmodule AoC.Day1504 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    mine_advent_coin(String.trim(input), 1)
  end

  @impl true
  def solve(:part2, input) do
    mine_advent_coin2(String.trim(input), 1)
  end

  def mine_advent_coin(secret, val) do
    str = "#{secret}#{val}"

    case :crypto.hash(:md5, str) do
      <<0::20, _::4, _::binary>> -> val
      _ -> mine_advent_coin(secret, val + 1)
    end
  end

  def mine_advent_coin2(secret, val) do
    str = "#{secret}#{val}"

    case :crypto.hash(:md5, str) do
      <<0::24, _::binary>> -> val
      _ -> mine_advent_coin2(secret, val + 1)
    end
  end
end
