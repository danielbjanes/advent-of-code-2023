defmodule Day4.Part1 do

  @moduledoc """
  https://adventofcode.com/2023/day/4

  In the below sample, card 1 has five winning numbers (41, 48, 83, 86, and 17)
  and eight numbers you have (83, 86, 6, 31, 17, 9, 48, and 53). Of the numbers
  you have, four of them (48, 83, 17, and 86) are winning numbers! That means
  card 1 is worth 8 points (1 for the first match, then doubled three times
  for each of the three matches after the first).
  """

  # @sample """
  # Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  # Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  # Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  # Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  # Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  # Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  # """

  def perform do

    File.open!("lib/day_4/raw.txt", [:read], fn file ->
      IO.read(file, :eof)
    end)
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      [_, winning, played] = String.split(line, ~r/[:|]/)

      win = String.split(winning, " ", trim: true)
      |> Enum.map(&String.to_integer(&1))

      play = String.split(played, " ", trim: true)
      |> Enum.map(&String.to_integer(&1))

      card_got = Enum.reduce(play, 0, fn num_played, acc ->
        cond do
          (num_played in win) && acc > 0 -> acc * 2
          num_played in win -> 1
          true -> acc
        end
      end)

      acc + card_got
    end)
  end
end
