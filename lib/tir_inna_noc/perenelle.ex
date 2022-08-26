defmodule TirInnaNoc.Perenelle do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: String.to_atom(state.board<>to_string(state.no)<>"Perenelle"))
  end

  @impl true
  def init(state) do
    IO.puts("watching thread "<>inspect(state))
    send(String.to_atom(state.board<>"Meldh"), {:checkin, state.no, self()})
    TirInnaNoc.Imageboard.thread(state.board, state.no) |> inspect |> IO.puts
    {:ok, state}
  end
end
