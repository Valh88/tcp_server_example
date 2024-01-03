defmodule KvServer.Command do

  def run(command)

  def run({:create, _bucket}) do
    {:ok, "OK\r\n"}
  end

  def run({:get, _bucket, _key}) do
    {:ok, "get"}
  end

  def run({:put, _bucket, _key, _value}) do
    {:ok, "put"}
  end

  def run({:delete, _bucket, _key}) do
    {:ok, "delte"}
  end

  def parse(line) do
    case String.split(line) do
      ["CREATE", bucket] -> {:ok, {:create, bucket}}
      ["GET", bucket, key] -> {:ok, {:get, bucket, key}}
      ["PUT", bucket, key, value] -> {:ok, {:put, bucket, key, value}}
      ["DELETE", bucket, key] -> {:ok, {:delete, bucket, key}}
      _ -> {:error, :unknown_command}
    end
  end
end
