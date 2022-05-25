macro IfNotUsedThenUsing(PackageName::String)
    return quote
        if !($PackageName in names(Main, imported = true))
            try
                @eval using $(Symbol(PackageName))
            catch
            end
        end
    end
end

export @IfNotUsedThenUsing