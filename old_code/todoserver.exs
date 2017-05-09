defmodule TodoServer do
  use GenServer #we use the GenServer module to define default callbacks2

#client functions called in the current process
  def start (todos) do
    {:ok, mytodos} = GenServer.start(__MODULE__, todos)
    mytodos
  end

  def add(mytodos, todo) do
    GenServer.cast(mytodos, {:add, todo})
  end

  def gettodos(mytodos) do
    GenServer.call(mytodos, mytodos, :todos)
  end


#server functions called in the context of the the GenServer Process
  """
  this is called when the gen server process starts up
  this passes in the arguments you pass to the start call
  """
  def init(todos) do
    {:ok, todos} #set up processes state
  end

  """
  handle_cast takes in the message that was sent as an arg and
  the current state of the process as the last arg
  sends back a tuple that starts with the :noreply atom
  """
  def handle_cast({:add, todo}, todos) do
    {:noreply, [todo | todos]}
  end

  #does the same as handle_cast but sends a message back to the caller
  def handle_call(:todos, _m, todos) do
    {:reply, todos, todos}
  end
end
