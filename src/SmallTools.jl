function SignalNormalization(A::AbstractVector{<:Real}; TriangularSignal::Bool = false)
    if TriangularSignal == true
        return (A .- Statistics.mean(A)) ./ (sqrt(2) * Statistics.std(A) * 2) .+ 0.5
    else
        return (A .- minimum(A)) ./ (maximum(A) - minimum(A))
    end
end

function SignalCut(TargetSignal::AbstractVector, ReferenceSignal::AbstractVector{<:Real}, Window::AbstractVector{<:Real})
    length(Window) == 2 || throw(ArgumentError("Invalid length of (Window = $Window), should be 2."))

    eachindex(TargetSignal) == eachindex(ReferenceSignal) ||
        throw(ArgumentError("Length and indexes of TargetSignal should be same as the length of ReferenceSignal."))

    S = similar(TargetSignal, Bool)

    for i in eachindex(TargetSignal)
        S[i] = true * (ReferenceSignal[i] >= Window[begin]) * (ReferenceSignal[i] <= Window[begin+1])
    end
    return TargetSignal[S]
end

function VectorSplit(TargetVector::AbstractVector, N::Int)
    L1 = length(TargetVector)
    L2 = trunc(Int64, L1 / N)
    X = L1 - N * L2

    Result = Vector{Vector{eltype(TargetVector)}}(undef, N)
    CutStart = eachindex(TargetVector)[1]
    for i = 1:N
        Result[i] = TargetVector[CutStart -1:CutStart-1+L2+((i-1)<X)]
        CutStart += L2 + (i < X)
    end

    return Result
end

function CurrentTask(FuncName::Symbol)
    S1 = "---------------------------------------------"
    S2 = "-Current Task: "
    S3 = "$(FuncName)\n"
    STR = join([S1, S2, S3])

    if length(STR) > displaysize(stdout)[2]
        CutLength = displaysize(stdout)[2]
        if CutLength < length(S2) + length(S3)
            CutLength = length(S2) + length(S3)
        end
        STR = STR[end-CutLength:end]
    end

    printstyled(STR; color = :blue)
end

export SignalCut
export SignalNormalization
export VectorSplit
export CurrentTask