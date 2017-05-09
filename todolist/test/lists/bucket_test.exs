defmodule TodoList.BucketTest do
  use ExUnit.Case, async: true

  test "stores values by key" do
    {:ok, bucket} = Lists.Bucket.start_link
    assert Lists.Bucket.get(bucket, "milk") == nil

    Lists.Bucket.put(bucket, "milk", 3)
    assert Lists.Bucket.get(bucket, "milk") == 3
  end
end
