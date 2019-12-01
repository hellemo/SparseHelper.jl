"""
Simulate sparse indices N out of N^2 NZs
"""
function fakesparse(N)
    return sample(1:N*N,N;replace=false,ordered=true)
end

"""
Generate test data, simulate sparse data read from data source
"""
function testdata(N=100)
    nt = Dict()
    t = Dict()
    at = []
    ant = []
    df = DataFrame(i = Int[],j=Int[],k=Int[],v=Float64[])
    for i in fakesparse(N), j in fakesparse(N), k in fakesparse(N)
        rv = rand()
        nt[(i=i,j=j,k=k)] = rv
        t[(i,j,k)] = rv
        push!(at,(i,j,k,rv))
        push!(ant,(i=i,j=j,k=k,v=rv))
        push!(df,(i,j,k,rv))
    end
    return t,nt,df,at,ant
end
