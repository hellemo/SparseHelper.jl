using Test
using SparseHelper
using JuMP

ts = [(i=:A,j=2,k=5),(i=:B,j=5,k=4),(i=:C,j=3,k=5)]

@testset "SparseHelper" begin
    I,J,K = sparsehelper(ts,3)
    @test I == [:A,:B,:C]
    @test J[:A] == [2]
    @test K[:A,2] == [5]
end

@testset "Convenience" begin
    @test length(select(ts,(;k=5))) == 2
    @test select(ts,(;i=:C))[1][1] == :C
    @test length(select(ts,(:*,:*,5))) == 2
    @test length(select(ts,(:*,*,5))) == 0
    @test select(ts,(:B,:*,:*))[1][1] == :B
end

@testset "Macros" begin
    m = Model()
    @sparsevariable(m,x[i,j,k] for (i,j,k) in ts)
    @test typeof(m[:x][:C,3,5]) == VariableRef
    @test name(m[:x][:C,3,5]) == "x[C, 3, 5]"
    @sparsevariable(m,y[i,j] for (i,j) = [(1,2),(100,200)])
    @test typeof(m[:y][100,200]) == VariableRef
    @sparsevariable(m,z[u] for u = [1,10])
    @test typeof(m[:z][1]) == VariableRef
    @sparsevariable(m, d[k,j,i] for (i,j,k) in ts) # switch order
    @test name(m[:d][5,3,:C]) == "d[5, 3, C]"
end