defmodule YahtzeeLowerSectionTest do
  use ExUnit.Case

  def generate(dice_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(dice_face)
    |> Enum.shuffle
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(dice_face, occurrences))
    |> Enum.shuffle
  end

  test "Identify 'Three of a kind' with ones" do
    dices = generate(1, 3)
    sum = Enum.sum(dices)
    assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
  end

  test "Identify 'Three of a kind' with all the others" do
    Enum.map(2..6, fn (dice_face) ->
      dices = generate(dice_face, 3)
      sum = Enum.sum(dices)
      assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Full house' with every face" do
    Enum.map(1..6, fn _ ->
      [x,y] =
        Enum.shuffle(1..6)
        |> Enum.take(2)
      assert %{"Full house": 25} = Yahtzee.score_lower([x,x,x,y,y] |> Enum.shuffle)
    end)
  end

  test "Identify 'Small straight' with all cases" do
    Enum.map(1..6, fn _ ->
      [x] =
        Enum.shuffle(1..3)
        |> Enum.take(1)
      [y] = Enum.shuffle(3..4)
        |> Enum.take(1)
      assert %{"Small straight": 30} = Yahtzee.score_lower([x,x+1,x+2,x+3,y] |> Enum.shuffle)
    end)
  end

  test "Identify 'Large straight' with every face" do
    Enum.map(1..6, fn _ ->
      [x] =
        Enum.shuffle(1..2)
        |> Enum.take(1)
      assert %{"Large straight": 40} = Yahtzee.score_lower([x,x+1,x+2,x+3,x+4] |> Enum.shuffle)
    end)
  end

  test "Identify 'Yahtzee'" do
    Enum.map(1..6, fn n ->
      assert %{Yahtzee: 50} = Yahtzee.score_lower(List.duplicate(n,5))
    end)
  end

  test "Identify any other combination" do
    Enum.map(1..6, fn _ ->
      [x,y,z] =
        Enum.shuffle(1..6)
        |> Enum.take(3)
      seq = Enum.shuffle([x,x,y,y,z])
      sum = Enum.sum(seq)
      assert %{Chance: ^sum} = Yahtzee.score_lower(seq)
    end)
  end


  test "Identify different categories for same face 1" do
    dice = [2,2,5,5,5]
    upper_output = %{
      Ones: 0,
      Twos: 2,
      Threes: 0,
      Fours: 0,
      Fives: 3,
      Sixes: 0
    }
    assert ^upper_output = Yahtzee.score_upper(dice)

    lower_output = %{
    "Three of a kind": 19,
    "Four of a kind": 0,
    "Full house": 25,
    "Small straight": 0,
    "Large straight": 0,
    Yahtzee: 0,
    Chance: 19
    }
    assert ^lower_output = Yahtzee.score_lower(dice)
  end





end
