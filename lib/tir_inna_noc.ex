defmodule TirInnaNoc do
  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("starting~")
    TirInnaNoc.Sup.start_link(name: :overseer)
    #{:ok, c} = Redix.start_link(host: "localhost", port: 6379, name: :redix)
    #Redix.command!(c, ["SET", "lol", "jews"])
    #Redix.command(c, ["GET", "lol"]) |> inspect |> IO.puts
    #{:ok, c}

  end
end
