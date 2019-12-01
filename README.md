# SparseHelper

Playground to experiment with convenience functions for working efficiently with sparse variables in [JuMP](https://github.com/JuliaOpt/JuMP.jl).

## Examples

For large numbers of dimensions and indices, problem construction is much more efficient when creating just the necessary variables:

```julia
using SparseHelper, JuMP

ts = [(i=:A,j=2,k=5),(i=:B,j=5,k=4),(i=:C,j=3,k=5)]
I,J,K = sparsehelper(ts,3)

m = Model()
@variable(m, x[i=I,j=J[i],k=K[i,j]])

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

## TO DO/Wishlist

- [ ] Create sparse @variable by simple iteration (like for @constraint)
- [ ] Create sparse @variable using generator-style syntax
- [x] Generate dicts to create sparse @variable
- [x] Select from tuples Gurobi style
- [x] Select from named tuples by name
- [ ] Select from @variable tuples (missing direct access to keys) 
- [ ] Select from @variable named tuples by name 
- [ ] Sum where select by index
- [ ] Sum where select by name
- [ ] Tests
- [ ] Documentation

## Feedback

Feedback, suggestions and pointers on how to work more elegantly and efficiently with sparse structures in JuMP is welcome!