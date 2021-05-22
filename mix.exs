defmodule NotionElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :notion_elixir,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: project_url(),
      homepage_url: project_url(),
      package: package(),
      description: description()
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

  defp package do
    [
      files: ["lib", "mix.exs", "LICENSE", "README.md"],
      maintainers: ["Michael Cordell"],
      licenses: ["MIT"],
      links: %{"GitHub" => project_url()}
    ]
  end

  defp project_url do
    """
    https://github.com/mcordell/notion_elixir
    """
  end

  defp description do
    """
    An Elixir API client for the Notion API.
    """
  end
end
