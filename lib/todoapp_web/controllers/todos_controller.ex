defmodule TodoappWeb.TodosController do
  import Ecto.Query, only: [from: 2]
  use TodoappWeb, :controller
  alias Todoapp.{Repo, Todo}


  # TODO add a Todo service

  def status(conn, %{"status" => status}) do
    changeset = Todo.changeset(%Todo{}, %{"completed": false})
    todos = case status do
      "active" -> Repo.all(from t in Todo, where: not t.completed)
      "completed" -> Repo.all(from t in Todo, where: t.completed)
      _ -> Repo.all(Todo)
    end
    render conn, "index.html", status: status, todos: todos, changeset: changeset
  end

  def create(conn, params) do
    IO.inspect params
    changeset = Todo.changeset(%Todo{}, params["todo"])
    if changeset.valid? do
      changeset |> Repo.insert
    end
    # TODO better error handling. see case https://hexdocs.pm/ecto/Ecto.Repo.html#content
    conn |> redirect(to: "/todos/all") |> halt()
  end
end
