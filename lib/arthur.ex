defmodule Arthur do
  def main([]) do
    error("you need args...")
  end

  def main(["shipit"]) do
    check_clean()
    run("mix test --cover")
    run("mix format")
    check_clean()
    run("git push origin HEAD")
  end

  def main(argv) do
    error("unexpected arguments #{inspect(argv)}")
  end

  defp run(cmd) do
    colorize("\n====> #{cmd}\n", [:color123])
    tokens = Regex.split(~r/\s+/, cmd)
    [command | args] = tokens
    {output, code} = System.cmd(command, args)
    IO.puts(output)

    unless code === 0 do
      System.halt(code)
    end
  end

  defp check_clean do
    {output, _code} = System.cmd("git", ["status", "--porcelain"])

    if String.length(String.trim(output)) > 0 do
      error('Please stash or commit changes first')
      System.halt(1)
    end
  end

  defp error(msg) do
    colorize(msg, [:bright, :red])
  end

  defp colorize(msg, colors) do
    IO.puts(Bunt.ANSI.format(colors ++ [msg], true))
  end
end

# COLORS: https://github.com/rrrene/bunt#256-colors
