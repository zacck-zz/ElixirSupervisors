**Supervisors**

These are borne of Erlang's error handling philosophy.

**Error Handling Philosophy**

The OTP framework treats failures in a different way, Here rather than trying to prevent crashes, we let them occur.

The remedy however is to isolate code into processes that cannot bring anything else down in the event they crash. Then we write code in the clearest way possible without trying to catch exceptions.

In the event of a crash OTP provides a way of automatically restarting crashed processes, named *Supervisors*.

**Supervisors**

These are processes responsible for watching other processes and restarting them if they crash for any reason.

Consider.

```Elixir
defmodule MyApp.Supervisor do
  #import supervisor features
  use Supervisor

  # a supervisor is a process too
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  #init function to set up the supervision proceses state
  def init([]) do
    #we define a children list that defines processes watched by this supervisor
    children = [
      #each sub process is defined with a call to worker which takes the same arguments as start_link in processes
      worker(ProcessA, [args]),
      worker(ProcessB, [args])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
```
