defmodule YahtzeeAllSectionTest do
  use ExUnit.Case

  test "Identify different categories for same dice config moodle" do
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

  test "Identify different categories for same dice config four of a kind" do
    dice = [1,1,1,2,1]
    upper_output = %{
      Ones: 4,
      Twos: 1,
      Threes: 0,
      Fours: 0,
      Fives: 0,
      Sixes: 0
    }

    assert ^upper_output = Yahtzee.score_upper(dice)

    lower_output = %{
      "Three of a kind": 6,
      "Four of a kind": 6,
      "Full house": 0,
      "Small straight": 0,
      "Large straight": 0,
      Yahtzee: 0,
      Chance: 6
      }
      assert ^lower_output = Yahtzee.score_lower(dice)
    end


    test "Identify different categories for same dice config Yahtzee" do
    dice = [5,5,5,5,5]
    upper_output = %{
      Ones: 0,
      Twos: 0,
      Threes: 0,
      Fours: 0,
      Fives: 5,
      Sixes: 0
    }

    assert ^upper_output = Yahtzee.score_upper(dice)

    lower_output = %{
      "Three of a kind": 25,
      "Four of a kind": 25,
      "Full house": 0,
      "Small straight": 0,
      "Large straight": 0,
      Yahtzee: 50,
      Chance: 25
      }
      assert ^lower_output = Yahtzee.score_lower(dice)
    end


    test "Identify different categories for same dice config large straight" do
      dice = [6,4,5,2,3]
      upper_output = %{
        Ones: 0,
        Twos: 1,
        Threes: 1,
        Fours: 1,
        Fives: 1,
        Sixes: 1
      }

      assert ^upper_output = Yahtzee.score_upper(dice)

      lower_output = %{
        "Three of a kind": 0,
        "Four of a kind": 0,
        "Full house": 0,
        "Small straight": 0,
        "Large straight": 40,
        Yahtzee: 0,
        Chance: 20
        }
        assert ^lower_output = Yahtzee.score_lower(dice)
      end
end
