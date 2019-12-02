using Test
using SparseHelper

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