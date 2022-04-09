defmodule Guess do
use Application
  @moduledoc """
  Documentation for `Guess`.
  """

  @doc """
  Welcome Guess Number.

  ## Examples

      iex> Guess.run()
      :world

  """
  def start(_,_) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Welcome Guess Number")
    IO.gets("Choose level (1,2 or 3):")
    |> parse_input()
    |> pickup_number()
    |> play()
    |> IO.inspect()
  end

  def guess(user_guess, picked_num, count) when user_guess > picked_num do
    IO.gets('#{count} of 7. To high,  try again: ')
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(user_guess, picked_num, count) when user_guess < picked_num do
    IO.gets('#{count} of 7. To lower,  try again: ')
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(_user_guess, _picked_num, count) do
    IO.puts('You got it on #{count} attempts')
  end

  def play(picked_num) do
    IO.gets('Enter your guess: ')
    |> parse_input()
    |> guess(picked_num, 1)
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def parse_input(:error) do
    IO.puts("Invalid number!")
    run()    
  end

  def parse_input({num, _} ), do: num

  def parse_input(data) do 
    data
    |> Integer.parse()
    |> parse_input()
  end

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts('Invalid level')
          run()
    end  
  end
end
