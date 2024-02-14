defmodule Openlibrary.Mixfile do
  use Mix.Project

  def project do
    [app: :openlibrary,
     version: "0.1.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: "Elixir client for Open Library REST API",
     package: package(),
    ]
  end

  def application do
    [
      applications: [
      :httpoison,
      :logger,
      :poison,
      ],
      extra_applications: [:isbn],
      mod: {Openlibrary, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.2"},
      {:isbn, ">= 0.1.0"},
      {:poison, "~> 5.0"},

      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  def package do
    [ name: :openlibrary,
      files: ["lib", "mix.exs"],
      maintainers: ["Nithin Bekal"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/nithinbekal/openlibrary"},
    ]
  end
end
