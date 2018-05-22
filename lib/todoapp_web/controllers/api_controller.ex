defmodule TodoappWeb.ApiController do
  import Ecto.Query, only: [from: 2]
  use TodoappWeb, :controller
  alias Todoapp.{Repo, Todo}

  def show(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)
    render conn, "show.json", todo: todo
  end

  def index(conn, %{"status" => status}) do
    todos = case status do
      "active" -> Repo.all(from t in Todo, where: not t.completed)
      "completed" -> Repo.all(from t in Todo, where: t.completed)
      _ -> Repo.all(Todo)
    end
    render conn, "index.json", todos: todos
  end

  def delete(conn, %{"id" => id}) do
    todo = Repo.get(Todo, id) # TODO Why do we need to fetch before delete?
    case Repo.delete todo do
      {:ok, struct}       -> conn |> send_resp(204, "todo #{id} deleted")
      {:error, changeset} -> conn |> send_resp(500, "todo #{id} not deleted") # TODO how to handle error?
    end
  end
end
