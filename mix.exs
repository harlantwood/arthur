defmodule Arthur.MixProject do
  use Mix.Project

  def project do
    [
      app: :arthur,
      version: "0.1.0",
      elixir: "~> 1.6",
      deps: deps(),
      escript: [
        main_module: Arthur
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bunt, "~> 0.2.0"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
