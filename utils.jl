function potential(x, t; alpha=0.5, T=1.0)
    t = mod(t, T)
    if t < 3/4
        return 0
    end

    x = mod(x, 1)
    if x < alpha
        return x/alpha
    else
        return (1-x)/(1-alpha)
    end
end


function potential_force_time_independent(x; alpha=0.5)
    x = mod(x, 1)
    if x < alpha
        return 1/alpha
    else
        return 1/(alpha - 1)
    end
end


function potential_force(x, t; alpha=0.5, T=1.0, time_dependent=true)
    t = mod(t, T)
    if t < 3*T/4 && time_dependent
        return 0
    end

    return potential_force_time_independent(x; alpha=alpha)
end


function stochastic()
    return randn()
end


function euler_step(x, t, dt, D; alpha=0.5, T=1.0, time_dependent=true)
    return x -
        potential_force(x, t, alpha=alpha, T=T, time_dependent=time_dependent) * dt +
        sqrt(2*D*dt) * stochastic()
end


function setup(
    r,  # nm
    L,  # Micro meter
    alpha,  # Dimensionless
    eta,  # m s Pa
    KbT,  # meV
    U  # eV
)
    """Given values, calculate dimensionless parameters"""

    gamma = 6*pi*eta*r  # Friction constant
    D = KbT / U
    omega = U / (gamma*L^2)

    return D, omega
end
