"""
jFoma.jl

(C) 2018 by Damir Cavar (http://damir.cavar.me/)

An example implementation of Foma access from Julia.

This example code will load a Foma Finite State Tranducer file, and return the analysis strings in
a Vector of Strings.

The assumptions are:

- you have Foma installed and Julia can find the dynamic library in the system-path.

For Foma, see the GitHub page:
https://fomafst.github.io
"""


const LIBNAME = "libfoma"
const MORPHOLOGY = "english.fst"


"""
Loading the network from a file specified in the variable MORPHOLOGY.
"""
function loadNet()
    ccall((:fsm_read_binary_file, LIBNAME), Ptr{Cvoid}, (Cstring,), MORPHOLOGY)
end


"""
Initializes the net and returns the init pointer.
"""
function initNet(net)
    ccall((:apply_init, LIBNAME), Ptr{Cvoid}, (Ptr{Cvoid},), net)
end


"""
Clears the init-pointer in the Foma library.
"""
function clearNet(ah)
    ccall((:apply_clear, LIBNAME), Cvoid, (Ptr{Cvoid},), ah)
end


"""
Frees the memory for the allocated FST.
"""
function destroyNet(net)
    ccall((:fsm_destroy, LIBNAME), Cvoid, (Ptr{Cvoid},), net)
end


"""
Applies UP to the net with the given token string.
"""
function applyUp(ah, token)
    res = Vector{String}()
    r = ccall((:apply_up, LIBNAME), Cstring, (Ptr{Cvoid}, Cstring), ah, token)
    while true
        if r == C_NULL
            break
        end
        push!(res, unsafe_string(r))
        r = ccall((:apply_up, LIBNAME), Cstring, (Ptr{Cvoid}, Cstring), ah, Ptr{UInt8}(C_NULL))
    end
    return res
end



"""
main function.
"""
function main()

    net = loadNet()
    ah = initNet(net)

    if isempty(ARGS)
        # sending the token "calls" through the analyser.
        println("calls:")
        result = applyUp(ah, String("calls"))
        for r in result
            println(r)
        end
    else
        for arg in ARGS
            println("$arg:")
            result = applyUp(ah, arg)
            for r in result
                println(r)
            end
        end
    end

    clearNet(ah)
    destroyNet(net)
end


main()
