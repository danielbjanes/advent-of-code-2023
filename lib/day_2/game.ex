defmodule Day2.Game do

  @moduledoc """
  https://adventofcode.com/2023/day/2

  max of 12 red cubes, 13 green cubes, and 14 blue cubes in each bag
  """

  @red_max 12
  @green_max 13
  @blue_max 14

  # @sample """
  # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  # Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  # Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  # Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  # Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  # """

  def perform do
    File.open!("lib/day_2/raw.txt", [:read], fn file ->
      IO.read(file, :eof)
    end)

    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->

      [id | games] = String.split(line, ~r/[:;]/)

      {id, _} = String.replace(id, ~r/\D+/, "")
      |> Integer.parse()

      max_pulled = Enum.reduce(games, %{"red" => 0, "green" => 0, "blue" => 0}, fn game, acc->
        pull = String.split(game, ~r/,/)
        |> Enum.reduce(%{"red" => 0, "green" => 0, "blue" => 0}, &check_color(&1, &2))

        cond_set(acc, pull, "red")
        |> cond_set(pull, "green")
        |> cond_set(pull, "blue")

      end)

      acc + (max_pulled["red"] * max_pulled["green"] * max_pulled["blue"])

    end)

  end

  def cond_set(acc, pull, color) do
    if acc[color] < pull[color] do
      Map.replace(acc, color, pull[color])
    else
      acc
    end
  end


  @doc """
  examples: " 5 green" => false
            " 17 blue" => true
            " 5 red" => false
  """
  def check_color(pull, acc) do
    [count, color] = String.split(pull, " ", trim: true)
    {num, _} = Integer.parse(count)

    Map.replace(acc, color, num)
  end

end
