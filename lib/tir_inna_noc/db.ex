defmodule TirInnaNoc.Db do
  use GenServer

  def start_link(_) do
    {:ok, conn} = Redix.start_link(host: "localhost", port: 6379, name: :db)
    GenServer.start_link(__MODULE__, conn, name: TirInnaNoc.Db)
  end

  def set(val, key) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["SET", key, val]})
  end
  def get(key) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["GET", key]})
  end
  def exists(key) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["EXISTS", key]})
  end
  def keys(pattern) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["KEYS", pattern]})
  end
  def hset(val, key, field) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["HSET", key, field, val]})
  end
  def hget(key, field) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["HGET", key, field]})
  end
  def sadd(member, key) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["SADD", key, member]})
  end
  def smembers(key) do
    GenServer.call(TirInnaNoc.Db, {:cmd, ["SMEMBERS", key]})
  end

  @impl true
  def init(c) do
    {:ok, c}
  end

  @impl true
  def handle_call({:cmd, command}, _from, c) do
    resp = Redix.command(c, command)
    {:reply, resp, c}
  end
end
