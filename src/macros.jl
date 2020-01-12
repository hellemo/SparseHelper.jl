import JuMP
"""
Create sparse variables in dictionary and register with model.
"""
macro sparsevariable(m,ex)
    v = ex.args[1].args[1] # variable
    vname = string(v)
    # For assignment to dictionary
    idx = ex.args[1].args[2:end]
    lhs = Expr(:ref,esc(v),tuple(idx...)...)
    rhs = :(JuMP.@variable($m))
    # For iteration
    itr = ex.args[2]
    i = itr.args[1]
    I = itr.args[2]
    return quote
        $(esc(v)) = $(esc(m))[Symbol($vname)] = Dict() # Create dictionary
        for $i in $(esc(I)) # Iterate over set I
            $(lhs) = JuMP.@variable($(esc(m)))
            JuMP.set_name($lhs, $vname * "[" *  join($(i),", ") * "]")
        end
    end
end