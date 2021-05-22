defmodule NotionElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :notion_elixir,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:jason, "~> 1.0"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.6"},
      {:ex_doc, "~> 0.24", only: :dev}
    ]
  end
end
