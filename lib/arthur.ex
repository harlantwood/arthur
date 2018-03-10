defmodule Arthur do
  def main([]) do
    IO.puts("you need args...")
  end

  def main(["shipit"]) do
    {output, code} = System.cmd("mix", ["test", "--cover"])
    IO.puts output
    unless (code === 0) do
      System.halt(code)
    end
  end

  def main(argv) do
    IO.puts("unexpected arguments #{argv}")
  end
end
