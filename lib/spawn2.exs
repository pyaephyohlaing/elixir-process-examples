#Handling multiple messages
defmodule Spawn2 do
    
    def greet do
        receive do
            {sender, msg} ->
                send sender, {:ok, "Hello, #{msg}"}
        end
    end

end

#here's a client
pid = spawn(Spawn2, :greet, [])
IO.inspect "pid1: "
IO.inspect pid
send pid, {self(), "World!"}
IO.inspect "self: "
IO.inspect self()
receive do
    {:ok, message} ->
        IO.puts message
end

send pid, {self(), "Kermit!"}
IO.inspect "pid2: "
IO.inspect pid
receive do
    {:ok, message} ->
        IO.puts message
end

