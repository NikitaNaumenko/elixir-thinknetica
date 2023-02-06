defmodule TestCluster do
  def start_slaves() do
    :ok = :net_kernel.monitor_nodes(true)
    _ = :os.cmd('epmd -daemon')

    Node.start(:"n1@127.0.0.1", :longnames)
    :slave.start_link(:"127.0.0.1", 'n2')
    :rpc.block_call(:"n2@127.0.0.1", :code, :add_paths, [:code.get_path()])
    :slave.start_link(:"127.0.0.1", 'n3')
    :rpc.block_call(:"n3@127.0.0.1", :code, :add_paths, [:code.get_path()])

    [node() | Node.list()]
  end

  def disconnect(list) do
    Enum.map(list, &Node.disconnect(&1))
  end
end

ExUnit.start()
