defmodule Day2506Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2506

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "123 328  51 64 ",
             " 45 64  387 23 ",
             "  6 98  215 314",
             "*   +   *   +  "
           ], 4_277_556}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2506.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2506.solve(:part1, AoC.fetch_input("2025", "06"))
    assert 5_552_221_122_013 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "123 328  51 64 ",
             " 45 64  387 23 ",
             "  6 98  215 314",
             "*   +   *   +  "
           ], 3_263_827}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2506.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2506.solve(:part2, AoC.fetch_input("2025", "06"))
    assert 11_371_597_082_440 < actual
    assert 11_371_597_126_232 == actual
  end
end
