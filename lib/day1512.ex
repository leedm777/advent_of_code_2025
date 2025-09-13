defmodule AoC.Day1512 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input |> Jason.decode!() |> deep_sum()
  end

  @impl true
  def solve(:part2, input) do
    input |> Jason.decode!() |> deep_sum2()
  end

  def deep_sum(s) when is_binary(s) do
    0
  end

  def deep_sum(i) when is_integer(i) do
    i
  end

  def deep_sum(lst) when is_list(lst) do
    lst |> Enum.map(&deep_sum/1) |> Enum.sum()
  end

  def deep_sum(m) when is_map(m) do
    m |> Map.values() |> Enum.map(&deep_sum/1) |> Enum.sum()
  end

  def deep_sum2(s) when is_binary(s) do
    0
  end

  def deep_sum2(i) when is_integer(i) do
    i
  end

  def deep_sum2(lst) when is_list(lst) do
    lst |> Enum.map(&deep_sum2/1) |> Enum.sum()
  end

  def deep_sum2(m) when is_map(m) do
    values = m |> Map.values()

    if Enum.any?(values, &(&1 == "red")) do
      0
    else
      values |> Enum.map(&deep_sum2/1) |> Enum.sum()
    end
  end
end
