defmodule Spawn3 do

    def greet do
        receive do
            {sender, msg} ->
                send sender, {:ok, "Hello, #{msg}"}
        end
    end

end

#here's a client
pid = spawn(Spawn3, :greet, [])
send pid, {self(), "World!"}
receive do
    {:ok, message} ->
        IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
    {:ok, message} ->
        IO.puts message
    #After 500 miliseconds, do this function
    after 500 ->
        IO.puts "The greet function is gone away"
end