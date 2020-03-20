include("utils.jl")
using Plots
using Printf
using Random
using Statistics

#Random.seed!(10)  # Used for debugging

D = 1/10

alpha = 0.2
dt = get_max_dt(D, alpha, 0.05)
t_end = 100.0
t = 0.0:dt:t_end

@printf("dt computed to %.2e\nNumber of steps: %i", dt, length(t))

x = Vector{Float64}(undef, length(t))
x[1] = 0

for i in eachindex(t[1:end-1])
    x[i+1] = euler_step(
        x[i],
        t[i],
        dt,
        D,
        alpha=alpha,
        time_dependent=false,
    )
end

pos = range(-0.6, 0.2, length=100)
pot = potential.(pos, 1, alpha=alpha, T=10.0, time_dependent=false)


traj = plot(t, x, title="D = 1/10")
# hist = histogram(x, normed=true)
# plot!(pos, boltzmann_dist.(pot, D))
