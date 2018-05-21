defmodule TodoappWeb.ApiController do
  use TodoappWeb, :controller

  def show(conn, _params) do
    todo = %{todo: "foo"}
    render conn, "show.json", todo: todo
  end

  def index(conn, _params) do
    todos = [%{description: "foo"}, %{description: "bar"}]
    render conn, "index.json", todos: todos
  end
end
