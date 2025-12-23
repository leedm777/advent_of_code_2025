defmodule AoC.Day2512 do
  @behaviour AoC.Solution

  @filled "#"
  @empty "."

  @impl true
  def solve(:part1, input) do
    sections =
      Enum.chunk_while(
        input,
        [],
        fn line, acc ->
          if line == "" do
            {:cont, Enum.reverse(acc), []}
          else
            {:cont, [line | acc]}
          end
        end,
        fn acc ->
          {:cont, Enum.reverse(acc), []}
        end
      )

    {regions_section, shapes_sections} = List.pop_at(sections, -1)

    shapes = Enum.map(shapes_sections, &parse_shape/1) |> Map.new()

    Enum.map(regions_section, &parse_region(&1, shapes))
    |> tap(&Enum.map(&1, fn r -> IO.puts(:stderr, region_to_string(r) <> "\n") end))

    # TODO:
    # - represent the region as a bigint
    # - use bitshift and or to position a shape on the regions
    # - use bitwise-and to detect collisions
    # - use bitwise-or to place the shape
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_region(line, shapes) do
    [size_str, cnts_str] = String.split(line, ": ")
    [width_str, length_str] = String.split(size_str, "x")
    width = String.to_integer(width_str)
    length = String.to_integer(length_str)

    {width, length, 0, String.split(cnts_str) |> Enum.map(&String.to_integer/1),
     map_shapes_to_region(shapes, width)}
  end

  def map_shapes_to_region(shapes, width) do
    Map.new(shapes, fn {idx, morphs} ->
      {idx,
       Enum.map(morphs, fn morph ->
         Enum.reduce(morph, 0, fn bits, acc ->
           Bitwise.bor(Bitwise.bsl(acc, width), bits)
         end)
       end)}
    end)
  end

  def region_to_string({width, length, bits, presents_wanted, shapes}) do
    region_lines =
      for row_num <- 0..(length - 1) do
        for col_num <- 0..(width - 1), reduce: "" do
          row ->
            row <>
              if 0 != Bitwise.bsl(1, row_num * width + col_num) |> Bitwise.band(bits) do
                @filled
              else
                @empty
              end
        end
      end

    presents_line = "[#{Enum.join(presents_wanted, ",")}]"
    Enum.join([inspect(shapes), presents_line | region_lines], "\n")
  end

  def parse_shape([id_str | grid_lines]) do
    id = String.to_integer(String.slice(id_str, 0..-2//1))

    grid_ch = Enum.map(grid_lines, &String.graphemes/1)

    {id, flip_and_rotate(grid_ch)}
  end

  def flip_and_rotate(grid_ch) do
    num_rows = length(grid_ch)
    num_cols = length(List.first(grid_ch))

    Enum.reduce(0..(num_rows - 1), List.duplicate([], 8), fn row_num, grids ->
      rows =
        Enum.reduce(
          0..(num_cols - 1),
          List.duplicate(0, 8),
          fn col_num, [row0, row1, row2, row3, row4, row5, row6, row7] ->
            [
              set_bit(row0, grid_ch, row_num, num_cols - 1 - col_num),
              set_bit(row1, grid_ch, row_num, col_num),
              set_bit(row2, grid_ch, num_rows - 1 - row_num, col_num),
              set_bit(row3, grid_ch, num_rows - 1 - row_num, num_cols - 1 - col_num),
              set_bit(row4, grid_ch, col_num, row_num),
              set_bit(row5, grid_ch, col_num, num_rows - 1 - row_num),
              set_bit(row6, grid_ch, num_cols - 1 - col_num, row_num),
              set_bit(row7, grid_ch, num_cols - 1 - col_num, num_rows - 1 - row_num)
            ]
          end
        )

      Enum.zip(rows, grids) |> Enum.map(fn {r, g} -> [r | g] end)
    end)
    |> Enum.uniq()

    # |> tap(fn gs ->
    #   Enum.with_index(gs)
    #   |> Enum.map(fn {g, idx} ->
    #     IO.puts(:stderr, idx)

    #     IO.puts(
    #       :stderr,
    #       g
    #       |> Enum.map(fn v -> v |> Integer.to_string(2) |> String.pad_leading(3, "0") end)
    #       |> Enum.join("\n")
    #     )

    #     IO.puts(:stderr, "")
    #   end)
    # end)
  end

  def set_bit(row, grid_ch, row_num, col_num) do
    ch = grid_ch |> Enum.at(row_num) |> Enum.at(col_num)

    if ch == @filled do
      Bitwise.bsl(row, 1) |> Bitwise.bor(1)
    else
      Bitwise.bsl(row, 1)
    end
  end
end
