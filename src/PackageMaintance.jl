# These codes are from the Julia discourse, https://discourse.julialang.org/t/how-to-see-all-installed-packages-a-few-other-pkg-related-questions/1231.

function PrintInstalledPackages(;FileName::String = "JuliaDependencies.txt")
    deps = [pair.second for pair in Pkg.dependencies()]
    direct_deps = filter(p -> p.is_direct_dep, deps)
    [(x.name, x.version) for x in direct_deps]
    pkg_list = [x.name for x in direct_deps]

    outfile = FileName
    open(outfile, "w") do f
        for i in pkg_list
            println(f, i)
        end
    end
end

function RestorePackages(;FileName::String = "JuliaDependencies.txt")
    infile = FileName
    open(infile, "r") do file
        for line in eachline(file)
            Pkg.add(line)
        end
    end
end

export PrintInstalledPackages
export RestorePackages
