defmodule TirInnaNoc.Imageboard.Post do
  defstruct post: %{}, sage: "u"
  def save(t, board) do
    GenServer.call(
      TirInnaNoc.Db,
      {
        :cmd,
        [
          "HSET",
          "post/"<>board<>"/"<>to_string(t.post["no"]),
          "postjson", Jason.encode!(t.post),
          "sage", t.sage
        ]
      }
    )
  end
end
