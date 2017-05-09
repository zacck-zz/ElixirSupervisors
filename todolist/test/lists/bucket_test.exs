defmodule TodoList.BucketTest do
  use ExUnit.Case, async: true

  setup  do
    {:ok, bucket} = Lists.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert Lists.Bucket.get(bucket, "milk") == nil

    Lists.Bucket.put(bucket, "milk", 3)
    assert Lists.Bucket.get(bucket, "milk") == 3
  end
end
