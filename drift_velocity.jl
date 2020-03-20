include("utils.jl")
using PyPlot
using Random
using Statistics
using Printf

#Random.seed!(10)  # Used for debugging

D = 2E-4
Ts = [100, 110, 120, 130, 140]

alpha = 0.2
t_end = 7000
num_iterations = 500  # Number of iterations for each period
dt = get_max_dt(D, alpha, 0.05)
t = 0:dt:t_end

setup_info = format_info(Dict([
    ("End time", t_end),
    ("steps each relization", length(t)),
    ("dt", dt),
    ("alpha", alpha),
    ("D", D),
    ("Ts", Ts),
    ("num iterations", num_iterations),
]))
print(setup_info)

x = Vector{Float64}(undef, length(t))
x[1] = 0

averages = Vector(undef, length(Ts))

for (i_T, T) in enumerate(Ts)
    sum = 0.0
    for iteration in 1:num_iterations
        @printf("\rT=%i [%s%s]", T, lpad('.', iteration, '.'), rpad(' ', 1+num_iterations-iteration)[2:end])
        for i in eachindex(t[1:end-1])
            x[i+1] = euler_step(
                x[i],
                t[i],
                dt,
                D,
                alpha=alpha,
                T=T,
            )
        end
        sum += x[end]
    end
    println()
    averages[i_T] = sum/num_iterations
end

println(averages)
plt.scatter(Ts, averages)
plt.show()

# average_lengths = Vector(undef, length(Ts))
# for i in eachindex(Ts)
#     average_lengths[i] = mean(x[end, i:i+num_iterations])
#     println(average_lengths[i])
#     plt.scatter(average_lengths[i], 0, label=Ts[i])
# end

# plt.axvline(color="gray", linestyle="dotted")
# plt.legend()
# plt.plot()

