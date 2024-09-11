defmodule CuidarMePrj.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CuidarMePrjWeb.Telemetry,
      CuidarMePrj.Repo,
      {DNSCluster, query: Application.get_env(:cuidarMePrj, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CuidarMePrj.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CuidarMePrj.Finch},
      # Start a worker by calling: CuidarMePrj.Worker.start_link(arg)
      # {CuidarMePrj.Worker, arg},
      # Start to serve requests, typically the last entry
      CuidarMePrjWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CuidarMePrj.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CuidarMePrjWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
