defmodule AoC.SolutionTest do
  use ExUnit.Case, async: true

  doctest AoC.Solution

  describe "move" do
    test "move right" do
      actual = AoC.Solution.move({10, 10}, ">")
      assert actual == {10, 11}
    end

    test "move down" do
      actual = AoC.Solution.move({10, 10}, "v")
      assert actual == {11, 10}
    end

    test "move left" do
      actual = AoC.Solution.move({10, 10}, "<")
      assert actual == {10, 9}
    end

    test "move up" do
      actual = AoC.Solution.move({10, 10}, "^")
      assert actual == {9, 10}
    end
  end
end
