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
    IO.gets("Choose level (1, 2 or 3):")
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def guess(_user_guess, _picked_num, count) when count > 7 do
    IO.puts('You failed, game finish!')
  end

  def guess(user_guess, picked_num, count) when user_guess > picked_num do
    IO.gets('#{count} of 7. Too high,  try again: ')
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(user_guess, picked_num, count) when user_guess < picked_num do
    IO.gets('#{count} of 7. Too lower,  try again: ')
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(_user_guess, _picked_num, count) do
    IO.puts('You got it on #{count} attempts')
    show_score(count)
  end

  def show_score(guesses) when guesses > 7 do
    IO.puts("Better luck next time!")
  end
  
  def show_score(guesses) do
    {_, msg} =  %{
      1..1 => "You're a powerfully lucker",
      2..4 => "Well, you're good!",
      5..6 => "You should been better than that!"}
      |> Enum.find(fn {range, _} -> Enum.member?(range, guesses) end)
      IO.puts(msg)
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
