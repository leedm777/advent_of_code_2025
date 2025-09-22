defmodule AoCTest do
  use ExUnit.Case, async: true

  doctest AoC

  describe "lines" do
    test "empty input" do
      actual = AoC.lines("")
      assert actual == [""]
    end

    test "expected" do
      actual = AoC.lines("foo\nbar\nbam\n")
      assert actual == ["foo", "bar", "bam"]
    end
  end
end
