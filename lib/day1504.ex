defmodule AoC.Day1504 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    mine_advent_coin(String.trim(input), 1, 20)
  end

  @impl true
  def solve(:part2, input) do
    mine_advent_coin(String.trim(input), 1, 24)
  end

  def mine_advent_coin(secret, val, num_leading_zero_bits) do
    str = "#{secret}#{val}"

    case :crypto.hash(:md5, str) do
      <<0::size(num_leading_zero_bits), _::bitstring>> -> val
      _ -> mine_advent_coin(secret, val + 1, num_leading_zero_bits)
    end
  end
end
