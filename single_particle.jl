include("utils.jl")
using Plots
using Random

# Random.seed!(10)  # Used for debugging

dt = 0.001
end_time = 1000
T = 100
D = 2E-2

t_range = 0:dt:end_time
x = Vector{Float64}(undef, length(t_range))

x[1] = 0
for (i, t) in enumerate(t_range[1:end-1])
    x[i+1] = euler_step(x[i], t, dt, D, T=T, alpha=0.2)
end

plot(t_range, x)
