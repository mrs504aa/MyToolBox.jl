module MyToolBox

function ArrayNormalization(A::Vector{<:Real})
    return (A .- minimum(A)) ./ (maximum(A) - minimum(A))
end

function SignalCut(TargetSignal::Vector{<:Real}, ReferenceSignal::Vector{<:Real}, Window::Vector{<:Real})
    length(Window) == 2 || throw(ArgumentError("Invalid length of (Window = $Window), should be 2."))
    length(TargetSignal) == length(ReferenceSignal) || throw(ArgumentError("Length of TargetSignal should be same as the length of ReferenceSignal."))
    S = Vector{Bool}(undef, length(ReferenceSignal))
    for i in 1:length(ReferenceSignal)
        S[i] = true * (ReferenceSignal[i] >= Window[1]) * (ReferenceSignal[i] <= Window[2])
    end
    return TargetSignal[S]
end

export ArrayNormalization
export SignalCut

end 
