using DataFrames
using DataFramesMeta  # To filter dataframes
using StatsBase       # To sample

using JuMP

module SparseHelper

include("helper.jl")
include("dummydata.jl")
include("convenient.jl")
include("macros.jl")

export sparsehelper
export select
export sum_where
export @sparsevariable

end # module
