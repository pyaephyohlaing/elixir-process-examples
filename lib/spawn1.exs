#Sending Messages between processes
defmodule Spawn1 do
    def greet do
        receive do
            {sender, msg} -> 
                IO.inspect "sender: "
                IO.inspect sender
                send sender, { :ok, "Hello, #{msg}"}
        end
    end
end

#here's a client
pid = spawn(Spawn1, :greet, [])
IO.inspect "pid: "
IO.inspect pid
IO.inspect "self1: "
IO.inspect self()
send pid, {self(), "World!"}

receive do
    {:ok, message} ->
        IO.puts message
end