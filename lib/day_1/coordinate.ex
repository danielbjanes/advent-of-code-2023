defmodule Day1.Coordinate do
  require File

 @moduledoc """
 https://adventofcode.com/2023/day/1

 Prompt: The newly-improved calibration document consists of lines of text;
 each line originally contained a specific calibration value that the Elves
 now need to recover. On each line, the calibration value can be found by
 combining the first digit and the last digit (in that order) to form a
 single two-digit number.

  For example:

  ```1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet```

  In this example, the calibration values of these four l
  ines are 12, 38, 15, and 77.
  Adding these together produces 142.
 """
  # @sample """
  # 1abc2
  # pqr3stu8vwx
  # a1b2c3d4e5f
  # treb7uchet
  # """

  # @sample2 """
  # two1nine
  # eightwothree
  # abcone2threexyz
  # xtwone3four
  # 4nineeightseven2
  # zoneight234
  # 7pqrstsixteen
  # """

  @lookup %{one: "o1e", two: "t2o", three: "t3e", four: "f4r", five: "f5e", six: "s6x", seven: "s7n", eight: "e8t", nine: "n9e"}

  def perform() do

    File.open!("lib/day_1/raw.txt", [:read], fn file ->
      IO.read(file, :eof)
    end)

    |> String.split("\n") # Make List from text on \n
    |> Enum.reduce(0, fn line, sum ->

      nums = Enum.reduce(@lookup, line, fn {key, value}, acc ->
        String.replace(acc, ~r/#{key}/, value)
      end)

      |> String.graphemes() # "1STRI2NG" -> ["1", "S", "T", "R", "I", "2", "N", "G"]
      |> Enum.filter(fn char -> # Loop through list and get rid of non INTS

        case Integer.parse(char) do # Tries to parse char
          :error -> false
          _ -> true
        end

      end) # ["1", "S", "T", "R", "I", "2", "N", "G"] -> ["1", "2"]


      if nums != [] do
        IO.inspect(String.to_integer(List.first(nums) <> List.last(nums)))
        sum + String.to_integer(List.first(nums) <> List.last(nums))
      else
        sum
      end

    end)

  end
end
