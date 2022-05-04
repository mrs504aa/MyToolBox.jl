function PrintInstalledPackages()
    deps = [pair.second for pair in Pkg.dependencies()]
    direct_deps = filter(p -> p.is_direct_dep, deps)
    [(x.name, x.version) for x in direct_deps]
    pkg_list = [x.name for x in direct_deps]

    outfile = "julia-dependencies.txt"
    open(outfile, "w") do f
        for i in pkg_list
            println(f, i)
        end
    end
end

function RestorePackages()
    infile = "julia-dependencies.txt"
    open(infile, "r") do file
        for line in eachline(file)
            Pkg.add(line)
        end
    end
end