defmodule Speaker do
  def speak do
    receive do
      {:say, msg} ->
        IO.puts(msg)
      _other -> 
    end
    speak
    #call ourselves if any message is present
  end
end
