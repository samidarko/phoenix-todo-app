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
    changeset = Todo.changeset(%Todo{}, params["todo"])
    if changeset.valid? do
      changeset |> Repo.insert
    end
    # TODO better error handling. see case https://hexdocs.pm/ecto/Ecto.Repo.html#content
    conn |> redirect(to: "/todos/all") |> halt()
  end

  def toggle(conn, params) do
    todo = Repo.get!(Todo, params["id"])
    todo = Ecto.Changeset.change todo, completed: !todo.completed
    case Repo.update todo do
      {:ok, struct}       -> conn |> redirect(to: "/todos/all") |> halt()
      {:error, changeset} -> conn |> redirect(to: "/todos/all") |> halt() # TODO how to handle error?
    end
  end

  def delete(conn, params) do
    # TODO handle correct redirection
    todo = Repo.get(Todo, params["id"])
    case Repo.delete todo do
      {:ok, struct}       -> conn |> redirect(to: "/todos/all") |> halt()
      {:error, changeset} -> conn |> redirect(to: "/todos/all") |> halt() # TODO how to handle error?
    end
  end

  def delete_confirmation(conn, params) do
    todo = Repo.get!(Todo, params["id"])
    changeset = Todo.changeset(%Todo{})
    IO.inspect todo
    # TODO raises Ecto.NoResultsError => return 404
    render conn, "delete_confirmation.html", todo: todo, changeset: changeset
  end
end
