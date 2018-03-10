defmodule Mix.Tasks.Arthur do
  use Mix.Task

  def run(args) do
    Arthur.main(args)
  end
end
