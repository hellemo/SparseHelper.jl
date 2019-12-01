"""
Construct dictionaries to set up sparse variables from list of tuples (ts)
"""
function sparsehelper(ts,dims::Integer)
    if dims == 1
        return unique((t[1] for t in ts))
    else
        completed = sparsehelper(ts,dims-1)
    end
    K = Dict()
    for t in ts
        if dims > 2
            if haskey(K,tuple(collect(t[i] for i in 1:dims-1)...))
                push!(K[tuple(collect(t[i] for i in 1:dims-1)...)],t[dims])
            else
                K[tuple(collect(t[i] for i in 1:dims-1)...)] = [t[dims]]
            end
        elseif dims == 2 
            if haskey(K,collect(t[i] for i in 1:dims-1)...)
                push!(K[collect(t[i] for i in 1:dims-1)...],t[dims])
            else
                K[collect(t[i] for i in 1:dims-1)...] = [t[dims]]
            end
        else
        end
    end
    for (k,v) in K
        K[k] = unique(v)
    end
    if dims == 2
        return completed,K
    else
        return (completed...,K)
    end
end