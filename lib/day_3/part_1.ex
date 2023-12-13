defmodule Day3.Part1 do

  @moduledoc """
  https://adventofcode.com/2023/day/3
  """

  @sample """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  def perform do
    File.open!("lib/day_3/raw.txt", [:read], fn file ->
      IO.read(file, :eof)
    end)
  end
end
