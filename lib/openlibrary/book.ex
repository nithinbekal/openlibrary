defmodule Openlibrary.Book do
  @moduledoc """
  Provides functions to find books from OpenLibrary.org by ISBN, LCCN, or OCLC identifiers.
  """

  @api_url "https://openlibrary.org/api"

  @doc """
  Fetch book information for given ISBN 10 or ISBN 13 number. Returns a map if
  result is found, `nil` if no result is found and `:invalid_isbn` if invalid.

      > Openlibrary.Book.find_by_isbn("0812511816")
      # %{ title: "The Eye of the World", authors: [%{}, %{}], ... }

      > Openlibrary.Book.find_by_isbn("invalidisbn")
      # :invalid_isbn

      > Openlibrary.Book.find_by_isbn("isbn not present in db")
      # nil

  """
  def find_by_isbn(isbn) do
    if ISBN.valid?(isbn) do
      find_by_bibkey("ISBN:#{isbn}")
    else
      :invalid_isbn
    end
  end

  @doc """
  Fetches book information for a list of ISBNs. Returns a map where the keys are
  the ISBNs and the values are the corresponding book information.

  The function constructs a single URL with all the ISBNs and makes a single request
  to the OpenLibrary API.

  ## Examples

      > Openlibrary.Book.find_by_isbns(["0812511816", "0451524934"])
      # %{
      #   "ISBN:0812511816" => %{ title: "The Eye of the World", authors: [%{}, %{}], ... },
      #   "ISBN:0451524934" => %{ title: "1984", authors: [%{}, %{}], ... }
      # }

      > Openlibrary.Book.find_by_isbns(["invalidisbn", "isbn not present in db"])
      # %{
      #   "ISBN:invalidisbn" => nil,
      #   "ISBN:isbn not present in db" => nil
      # }

  """
  def find_by_isbns(isbns) do
    isbns
    |> Enum.map(fn isbn -> "ISBN:#{isbn}" end)
    |> Enum.join(",")
    |> find_by_bibkeys()
  end

  @doc """
  Fetch book information using Library of Congress catalog number.

      > Openlibrary.Book.find_by_lccn("lccn")
      # %{ title: "The Eye of the World", authors: [%{}, %{}], ... }

  """
  def find_by_lccn(lccn) do
    find_by_bibkey("LCCN:#{lccn}")
  end

  @doc """
  Fetch book information using Worldcat Control Number.

      > Openlibrary.Book.find_by_oclc("oclc")
      # %{ title: "The Eye of the World", authors: [%{}, %{}], ... }

  """
  def find_by_oclc(oclc) do
    find_by_bibkey("OCLC:#{oclc}")
  end

  defp find_by_bibkey(bibkey) do
    # bibkey can be ISBN, LCCN, or OCLC.
    "#{@api_url}/books?bibkeys=#{bibkey}&jscmd=data&format=json"
    |> fetch_json()
    |> Map.get(bibkey)
  end

  defp find_by_bibkeys(bibkeys) do
    "#{@api_url}/books?bibkeys=#{bibkeys}&jscmd=data&format=json"
    |> fetch_json()
  end

  defp fetch_json(url) do
    url
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
  end
end
