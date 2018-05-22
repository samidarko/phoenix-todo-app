defmodule TodoappWeb.ApiView do
  use TodoappWeb, :view

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, TodoappWeb.ApiView, "todo.json", as: :todo)}
  end

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, TodoappWeb.ApiView, "todo.json", as: :todo)}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id, description: todo.description, completed: todo.completed}
  end

end
