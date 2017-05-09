defmodule Lists.RegistryTest do
  use ExUnit.Case, async: true

  #set up work
  setup  do
    {:ok, registry} = Lists.Registry.start_link
    {:ok, registry: registry}
  end

  test "Spawns buckets", %{registry: registry} do
    assert Lists.Registry.lookup(registry, "coding") == :error

    Lists.Registry.create(registry, "coding")
    assert{:ok, bucket} = Lists.Registry.lookup(registry, "coding")

    Lists.Bucket.put(bucket, "elixir", 1)
    assert Lists.Bucket.get(bucket, "elixir") == 1
  end

  test "removed buckets on exit", %{registry: registry} do
    Lists.Registry.create(registry, "developers")
    {:ok, bucket} = Lists.Registry.lookup(registry, "developers")
    Agent.stop(bucket)
    assert Lists.Registry.lookup(registry, "developers") == :error
  end
end
