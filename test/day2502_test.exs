defmodule Day2502Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2502

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
           ], 1_227_775_554}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2502.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2502.solve(:part1, AoC.fetch_input("2025", "02"))
    assert 64_215_794_229 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
           ], 4_174_379_265}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2502.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2502.solve(:part2, AoC.fetch_input("2025", "02"))
    assert 85_513_235_135 == actual
  end
end
