defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    KV.Bucket.put(bucket, "water", 2)
    KV.Bucket.delete(bucket, "water")
    assert KV.Bucket.get(bucket, "water") == nil
  end

  test "are temporary buckets" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
