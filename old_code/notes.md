The `cast` function in GenServer will send a message without waiting for a reply.

The `call` function on the other hand will send a message to the server and pause for feedback.


**GenServer Features**

- GenServer processes are distributed across cores.
- A GenServer process works on one message at a time.
- GenServer Processes can be supervised and restarted.
- GenServer process state can be upgraded in place.
