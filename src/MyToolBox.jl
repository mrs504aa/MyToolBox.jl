module MyToolBox

function ArrayNormalization(A::Vector{<:Real})
    return (A .- minimum(A)) ./ (maximum(A) - minimum(A))
end

function SignalCut(TargetSignal::Vector{<:Real}, ReferenceSignal::Vector{<:Real}, Window::Vector{<:Real})
    S = Vector{Bool}(undef, length(ReferenceSignal))
    for i in 1:length(ReferenceSignal)
        S[i] = true * (ReferenceSignal[i] >= Window[1]) * (ReferenceSignal[i] <= Window[2])
    end
    return TargetSignal[S]
end

export ArrayNormalization
export SignalCut

end 
