defmodule TirInnaNoc.Perenelle do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: String.to_atom(elem(state, 0)<>to_string(elem(state, 1))<>"Perenelle"))
  end

  @impl true
  def init(state) do
    IO.puts("watching thread "<>inspect(state))
    send(String.to_atom(elem(state, 0)<>"Meldh"), {:checkin, elem(state, 1), self()})
    {:ok, state}
  end
end
