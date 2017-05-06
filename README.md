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
%{"authors" => [%{"name" => "Robert Jordan",
     "url" => "https://openlibrary.org/authors/OL2645644A/Robert_Jordan"}],
  "by_statement" => "Robert Jordan",
  "classifications" => %{"dewey_decimal_class" => ["823.914"],
    "lc_classifications" => ["PS3560.O7617 E94 1990"]},
  "cover" => %{...},
  "ebooks" => [...],
  "identifiers" => %{
    "isbn_10" => ["0812511816", "081257995X", "0613176340", "0812500482"],
    "isbn_13" => ["9780812511819", "9780812579956", "9780613176347", "9780812500486"],
    "lccn" => ["89007939"], "oclc" => ["22671036"],
    "openlibrary" => ["OL24934473M"]
  },
  "key" => "/books/OL24934473M",
  "number_of_pages" => 814, "pagination" => "814 p. :",
  "publish_date" => "1990", "publish_places" => [%{"name" => "New York"}],
  "publishers" => [%{"name" => "T. Doherty Associates"}],
  "subjects" => [%{"name" => "Fantasy .", "url" => "https://openlibrary.org/subjects/fantasy_."}]}
```

## Credits

Reading through the source of the [openlibrary gem](https://github.com/jayfajardo/openlibrary)
by [jayfajardo](https://github.com/jayfajardo) has been a massive help in
creating this package.

