function IfNotUsedThenUsing(PackageName::String)
    if !(PackageName in names(Main, imported = true))
        try
            @eval using $(Symbol(PackageName))
        catch
        end
    end
end

function IfNotUsedThenUsing(PackageList::Vector{String})
    for PackageName in PackageList
        IfNotUsedThenUsing(PackageName)
    end
end

export IfNotUsedThenUsing