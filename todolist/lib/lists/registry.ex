defmodule Lists.Registry do
  use GenServer

  #Client API
  @doc """
  Starts the Registry
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok , [])
  end

  @doc """
  Look up the bucket pid foe `name` stored in `server`

  Returns `{:ok, pid}` if the bucket exists `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket associated to the given `name` in `server`
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  """
  Server CallBacks
  recieves the second argumenet from .start_link above
  """
  def init(:ok)  do
    #returns {ok, state} where state is a map
    {:ok, %{}}
  end

  """
  this recieves the request(tuple), the process from which we got the request _from
  and  the current state `names`
  returns a tuple in the format {:reply, reply, new_state}
  :reply indicates the server should return a reply
  reply is what will be sent back to the client
  new_state  the new server state
  """
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  """
  this recived the request and the current server state
  this returns a tuple {:noreply, new_state}

  """
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = Lists.Bucket.start_link
      {:noreply, Map.put(names, name, bucket)}
    end
  end

end
