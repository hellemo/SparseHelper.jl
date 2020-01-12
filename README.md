# SparseHelper

Playground to experiment with convenience functions for working efficiently with sparse variables in [JuMP](https://github.com/JuliaOpt/JuMP.jl).

## Examples

For large numbers of dimensions and indices, problem construction is [much more efficient when creating just the necessary variables](https://discourse.julialang.org/t/working-efficiently-with-sparse-variables-in-jump/32240/):

```julia
using SparseHelper, JuMP

ts = [(i=:A,j=2,k=5),(i=:B,j=5,k=4),(i=:C,j=3,k=5)]
I,J,K = sparsehelper(ts,3)

m = Model()
@variable(m, x[i=I,j=J[i],k=K[i,j]])

```

WIP: Macro to create sparse variables directly:
```julia
m = Model()
@sparsevariable(m,x[i,j,k] for (i,j,k) in ts)
```


Alternatively, one may wish to create the variables over the tuples directly:

```julia
m = Model()
@variable(m, x[ts])
```

That makes working with indices later a bit more involved, though. This can be made more convenient with a few helper functions:

```julia
# With named tuples.
# Select tuples where k=5:
select(ts,(;k=5))
```
If you don't use named tuples, use :* as wildcard:

```julia
# If not using named tuples
nnts = values.(ts)
select(nnts,(:*,:*,5))
```

WIP: For convenience, sum over tuples that match the search criterion:

```julia
@constraint(m,sum_where(x,(;k=5)) <=10)

@variable(m,y[ts])
@constraint(m,sum_where(y,(:*,:*,5)) <=10)
```

## Feedback

Feedback and suggestions for improvements is welcome!