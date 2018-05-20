# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todoapp.Repo.insert!(%Todoapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Todoapp.Repo.insert!(%Todoapp.Todo{description: "Go shopping", completed: false})
Todoapp.Repo.insert!(%Todoapp.Todo{description: "Get a haircut", completed: true})
