defmodule Guardian.DB.Mixfile do
  use Mix.Project

  @version "1.1.0"
  @source_url "https://github.com/ueberauth/guardian_db"

  def project do
    [
      name: "Guardian.DB",
      app: :guardian_db,
      version: @version,
      description: "DB tracking for token validity",
      elixir: "~> 1.4 or ~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      docs: docs(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [guardian_db: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:guardian, "~> 1.0"},
      {:ecto, "~> 3.0.0-rc.0"},
      {:ecto_sql, "~> 3.0.0-rc.0"},
      {:postgrex, "~> 0.14-rc.1", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Daniel Neighman", "Sean Callan", "Sonny Scroggin"],
      licenses: ["MIT"],
      links: %{GitHub: @source_url},
      files: [
        "lib",
        "CHANGELOG.md",
        "LICENSE",
        "mix.exs",
        "README.md",
        "priv/templates"
      ]
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp aliases do
    [
      test: [
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "guardian.db.gen.migration",
        "ecto.migrate",
        "test"
      ]
    ]
  end
end
