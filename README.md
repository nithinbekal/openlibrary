# Openlibrary

Elixir client for [Open Library Rest API](https://openlibrary.org/dev/docs/restful_api).

Work in progress. Currently only supports fetching book information for a given ISBN.

## Installation

Add `openlibrary` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:openlibrary, "~> 0.1.0"}]
end
```

Ensure `openlibrary` is started before your application:

```elixir
def application do
  [applications: [:openlibrary]]
end
```

## Usage

```elixir
Openlibrary.Book.find_by_isbn("1408845644")
#=> Returns a map.
```

