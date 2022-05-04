function HamiltonianTest(Kx, Ky, Paras)
    t, mu, delta = Paras

    M = zeros(ComplexF64, 2, 2)
    M[1, 1] = -2 * t * cos(Kx) - 2 * t * cos(Ky) - mu
    M[2, 2] = 2 * t * cos(Kx) + 2 * t * cos(Ky) + mu
    M[1, 2] = delta * (sin(Kx) - im * sin(Ky))
    M[2, 1] = delta * (sin(Kx) + im * sin(Ky))

    return M
end

function ULink(MU::Tuple{Float64,Float64}, KL::Tuple{Float64,Float64}, HamiltonianDim::Int64, HamiltonianModel, Paras::Tuple)
    Kx, Ky = KL
    Kx1, Ky1 = MU

    EIG0 = LinearAlgebra.eigen(HamiltonianModel(Kx, Ky, Paras))
    V0 = EIG0.vectors[:, sortperm(real.(EIG0.values))]
    EIG1 = LinearAlgebra.eigen(HamiltonianModel(Kx + Kx1, Ky + Ky1, Paras))
    V1 = EIG1.vectors[:, sortperm(real.(EIG1.values))]

    Result = zeros(ComplexF64, HamiltonianDim)
    for i in 1:HamiltonianDim
        Result[i] = LinearAlgebra.dot(V0[:, i], V1[:, i]) # auto conjugate in julia
        Result[i] /= abs(Result[i])
    end
    return Result
end

function LatticeField(KL::Tuple{Float64,Float64}, Tick::Tuple{Float64,Float64}, HamiltonianDim::Int64, HamiltonianModel, Paras::Tuple)
    Kx, Ky = KL
    KxTick, KyTick = Tick
    Result = fill(1.0 + 0.0 * im, HamiltonianDim)

    Result .*= ULink((KxTick, 0.0), (Kx, Ky), HamiltonianDim, HamiltonianModel, Paras)
    Result .*= ULink((0.0, KyTick), (Kx + KxTick, Ky), HamiltonianDim, HamiltonianModel, Paras)
    Result .*= ULink((-KxTick, 0.0), (Kx + KxTick, Ky + KyTick), HamiltonianDim, HamiltonianModel, Paras)
    Result .*= ULink((0.0, -KyTick), (Kx, Ky + KyTick), HamiltonianDim, HamiltonianModel, Paras)

    F = imag.(log.(Result))

    for i in 1:HamiltonianDim
        while F[i] < -pi
            F[i] += 2 * pi
        end
        while F[i] > +pi
            F[i] -= 2 * pi
        end
    end

    return F
end

function ChernNumber(HamiltonianModel, Paras::Tuple; HamiltonianDim::Int64, KxLim::Vector{<:Real}, KyLim::Vector{<:Real},
    Density::Int64=21)

    KxAxis = range(KxLim[1], KxLim[2], Density)
    KxTick = (KxAxis[end] - KxAxis[1]) / (Density - 1)

    KyAxis = range(KyLim[1], KyLim[2], Density)
    KyTick = (KyAxis[end] - KyAxis[1]) / (Density - 1)

    ResultM = zeros(Float64, HamiltonianDim, Density, Density)

    for i in 1:(Density-1)
        for j in 1:(Density-1)
            ResultM[:, i, j] = LatticeField((KxAxis[i], KyAxis[j]), (KxTick, KyTick), HamiltonianDim, HamiltonianModel, Paras)
        end
    end

    Result = zeros(Float64, HamiltonianDim)
    for i in 1:HamiltonianDim
        Result[i] = sum(ResultM[i, :, :])
    end

    return Result ./ (2 * pi), ResultM ./ (KxTick * KyTick)
end

function ChernNumberExample()
    Paras = (4, 1, 6)
    C, Field = ChernNumber(HamiltonianTest, Paras, HamiltonianDim=2, KxLim=[0, 2 * pi], KyLim=[0, 2 * pi])
    println("Chern number: ", C)
end

export ChernNumber
export ChernNumberExample