defmodule Mix.Tasks.Arthur do
  @moduledoc """
  Adds `mix arthur` task to your project
  """
  use Mix.Task

  def run(args) do
    Arthur.main(args)
  end
end
