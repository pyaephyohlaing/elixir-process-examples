defmodule Chain do
    
    def counter(next_pid) do
        receive do
            IO.inspect "next_pid"
            IO.inspect next_pid
            n -> 
                IO.inspect "n"
                IO.inspect n
                IO.inspect "next_pid"
                IO.inspect next_pid
                send next_pid, n+1
        end
    end

    def create_processes(n) do
        code_to_run = fn(_, send_to) ->
           IO.inspect "self()"
           IO.inspect send_to
        #spwan function send send_to params to counter function.
          spawn(Chain, :counter, [send_to])
        end

        last = Enum.reduce(1..n, self(), code_to_run)
        IO.inspect "This is last"
        IO.inspect last

        send(last, 0) #start the count by sending a zero to the last process

        receive do       # and wait for the result to come back to us
            final_answer when is_integer(final_answer) -> 
                "Result is #{inspect(final_answer)}"
        end
       
    end

    def run(n) do
        :timer.tc(Chain, :create_processes, [n])
        |> IO.inspect
    end

end

