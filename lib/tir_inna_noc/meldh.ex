defmodule TirInnaNoc.Meldh do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: String.to_atom(elem(state, 0)<>"Meldh"))
  end

  @impl true
  def handle_info({:checkin, no, pid}, state) do
    state = {elem(state, 0), Map.put(elem(state, 1), no, pid)}
    {:noreply, state}
  end

  @impl true
  def init(state) do
    IO.puts("started meldh to archive board "<>elem(state, 0))
    {:ok, res} = TirInnaNoc.Imageboard.threads(elem(state, 0))
    res.body
    |> Enum.each(fn page ->
      Enum.each(page["threads"], fn thread ->
        DynamicSupervisor.start_child(
          String.to_atom(elem(state, 0)<>"Supervisor"),
          {TirInnaNoc.Perenelle, {elem(state, 0), thread["no"]}}
        )
      end)
    end)
    {:ok, state}
  end
end
