function select(ts,criterion::Tuple)
    @assert(length(ts[1])==length(criterion))
    for (i,c) in enumerate(criterion)
        ts =  filter(x->(criterion[i]==:*) || (x[i]==c),ts) 
    end
    return ts
end

function select(ts_in,criterion::NamedTuple)
    ts = copy(ts_in)
    for k in keys(criterion)
        ts = filter!(x->(x[k]==criterion[k]),ts)
    end
    return ts
end

"""
NB! Just a demo, not rubust in any way!
"""
function sum_where(x,criterion)
    ts = select(collect(keys(x.lookup[1])),criterion)
    return sum(x.data[[x.lookup[1][t] for t in ts]])
end