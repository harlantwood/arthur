defmodule Arthur.MixProject do
  use Mix.Project

  def project do
    [
      app: :arthur,
      version: "0.1.0",
      elixir: "~> 1.6",
      deps: deps(),
      test_coverage: [tool: Coverex.Task, coveralls: true, ignore_modules: []]
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
      {:bunt, "~> 0.2.0"},
      {:coverex, "~> 1.4.10", only: :test},
      {:credo, "~> 1.0.3", only: [:dev, :test], runtime: false}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
