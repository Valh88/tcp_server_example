defmodule KvServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "4041")
    children = [
      # Starts a worker by calling: KvServer.Worker.start_link(arg)
      # {KvServer.Worker, arg}
      # {Task, fn -> KVServer.accept(port) end}

      {Task.Supervisor, name: KVServer.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> KVServer.accept(port) end}, restart: :permanent)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KvServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
