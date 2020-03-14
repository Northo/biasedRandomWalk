include("utils.jl")

using Plots
using Random

#Random.seed!(10)  # Used for debugging

dt = 0.01
end_time = 10
D = 0.5
alpha = 0.3
T = 1
num_particles = 1000

t_range = 0:dt:end_time
x = Array{Float64, 2}(undef, length(t_range), num_particles)

x[1, :] = zeros(num_particles)
for (i, t) in enumerate(t_range[1:end-1])
    x[i+1, :] = euler_step.(x[i, :], t, dt, D; alpha=alpha, T=T)
end
