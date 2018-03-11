alias Bunt.ANSI, as: BuntANSI

defmodule Arthur do
  @moduledoc """
  Arthur helps you keep your Elixir code quality high!
  """

  def main([]) do
    error("you need args...")
  end

  def main(["check"]) do
    prereqs()
    quality()
  end

  def main(["fix"]) do
    prereqs()
    fix()
  end

  def main(["push" | opts]) do
    check_clean()
    run_hooks(:push, :pre)
    prereqs()
    quality()
    fix()
    run_hooks(:push, :post)
    check_clean()
    run("git push origin HEAD #{Enum.join(opts, " ")}")
  end

  def main(["ci"]) do
    run_hooks(:ci, :pre)
    quality()
    run("mix format --check-formatted")
    run_hooks(:ci, :post)
  end

  def main(argv) do
    error("unexpected arguments #{inspect(argv)}")
  end

  def prereqs do
    run("mix deps.get")
  end

  defp fix do
    run("mix format")
  end

  defp quality do
    run("mix test --cover")
    run("mix credo --all --strict")
  end

  defp run_hooks(arthur_command, timing) do
    local_config = Application.get_env(:arthur, arthur_command)
    shell_commands = local_config[timing] || []
    Enum.each(shell_commands, fn cmd -> run(cmd) end)
  end

  defp run(cmd) do
    cmd = String.trim(cmd)
    colorize("\n--->>> #{cmd}\n", [:color123])
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
    end
  end

  defp error(msg) do
    colorize("#{msg}\n", [:bright, :red])
    System.halt(1)
  end

  defp colorize(msg, colors) do
    # credo:disable-for-next-line Credo.Check.Refactor.AppendSingleItem
    IO.puts(BuntANSI.format(colors ++ [msg], true))
  end
end

# COLORS: see https://github.com/rrrene/bunt#256-colors
