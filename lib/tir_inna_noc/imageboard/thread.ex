defmodule TirInnaNoc.Imageboard.Thread do
  defstruct board: "", no: 0, last_update: 0, on_page: 0, reply_number: 0, posts: []
  def save(t) do
    GenServer.call(
      TirInnaNoc.Db,
      {
        :cmd,
        [
          "HSET",
          "thread/"<>t.board<>"/"<>to_string(t.no),
          "last_update", t.last_update,
          "on_page", t.on_page,
          "reply_number", t.reply_number,
          "posts", t.posts|>Enum.map(fn p -> to_string(p.post["no"]) end)|>Enum.join(",")
        ]
      }
    )
  end
end
