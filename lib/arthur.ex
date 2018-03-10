defmodule Arthur do
  def main([]) do
    IO.puts("you need args...")
  end

  def main(["shipit"]) do
    check_clean()
    run("mix test --cover")
    run("mix format")
    check_clean()
    run("git push origin HEAD")
  end

  def main(argv) do
    IO.puts("unexpected arguments #{argv}")
  end

  defp run(cmd) do
    IO.puts("\n====> #{cmd}\n")
    tokens = Regex.split(~r/\s+/, cmd)
    [command | args ] = tokens
    # IO.inspect([command, args])
    {output, code} = System.cmd(command, args)
    IO.puts(output)

    unless code === 0 do
      System.halt(code)
    end
  end

  defp check_clean do
    {output, _code} = System.cmd("git", ["status", "--porcelain"])
    if String.length(String.trim(output)) > 0 do
      error 'Please stash or commit changes first'
      System.halt(1)
    end
  end

  defp error(msg) do
    IO.puts("\n#{msg}\n")
  end
end
