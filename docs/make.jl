using LibAwsMqtt
using Documenter

DocMeta.setdocmeta!(LibAwsMqtt, :DocTestSetup, :(using LibAwsMqtt); recursive=true)

makedocs(;
    modules=[LibAwsMqtt],
    repo="https://github.com/JuliaServices/LibAwsMqtt.jl/blob/{commit}{path}#{line}",
    sitename="LibAwsMqtt.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://github.com/JuliaServices/LibAwsMqtt.jl",
        assets=String[],
        size_threshold=2_000_000, # 2 MB, we generate about 1 MB page
        size_threshold_warn=2_000_000,
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/JuliaServices/LibAwsMqtt.jl", devbranch="main")
