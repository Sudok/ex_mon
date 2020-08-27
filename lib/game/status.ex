defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message() do
    IO.puts("\n============ Game iniciado ============ \n")
    IO.inspect(Game.info)
    IO.puts('------------------------------')
  end
end
