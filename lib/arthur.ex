defmodule Arthur do
  def main([]) do
    error("you need args...")
  end

  def main(["push" | opts]) do
    check_clean()
    run("mix deps.get")
    run("mix test --cover")
    run("mix format")
    check_clean()
    run("git push origin HEAD #{Enum.join(opts, " ")}")
  end

  def main(["ci"]) do
    run("mix test --cover")
    run("mix format --check-formatted")
  end

  def main(argv) do
    error("unexpected arguments #{inspect(argv)}")
  end

  defp run(cmd) do
    cmd = String.trim(cmd)
    colorize("\n→ → #{cmd}\n", [:color123])
    tokens = Regex.split(~r/\s+/, cmd)
    [command | args] = tokens
    {output, code} = System.cmd(command, args)

    if String.length(String.trim(output)) > 0 do
      IO.puts(output)
    end

    unless code === 0 do
      System.halt(code)
    end

    {output, code}
  end

  defp check_clean do
    {output, _code} = run("git status --porcelain")

    if String.length(String.trim(output)) > 0 do
      error('Please stash or commit changes')
      System.halt(1)
    end
  end

  defp error(msg) do
    colorize("#{msg}\n", [:bright, :red])
  end

  defp colorize(msg, colors) do
    IO.puts(Bunt.ANSI.format(colors ++ [msg], true))
  end
end

# COLORS: see https://github.com/rrrene/bunt#256-colors
