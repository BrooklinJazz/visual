defmodule Visual.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Visual.Worker.start_link(arg)
      # {Visual.Worker, arg}
    ]

    Kino.SmartCell.register(Visual)
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Visual.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
