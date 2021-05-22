# NotionElixir

An Elixir API client for the Notion API - [\[Notion Documentation\]][notion-api-docs]


## Installation

Add `notion_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
	#...
    {:notion_elixir, "~> 0.1.0"}
	#...
  ]
end
```

## Configuration

In a configuration file, add your Notion API key by configuring as so:

```elixir
config :notion_elixir,
  api_key: "secret_NOTION_API_KEY",
```

[notion-api-docs]: https://developers.notion.com/reference/intro
