defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Glauber"
      }

      assert expected_response == ExMon.create_player("Glauber", :soco, :chute, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started" do
      player = ExMon.create_player("Glauber", :soco, :chute, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "Game iniciado"
      assert messages =~ "status: :started"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Glauber", :soco, :chute, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end
  end
end
