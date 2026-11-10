using LinearAlgebra
using Plots
using LaTeXStrings

function cg(A, b; tol=1e-4, max_iter=2000)
    m = length(b)
    x = zeros(Float64, m)
    r = b - A * x
    p = copy(r)
    
    res = [norm(r)]
    
    for k in 0:max_iter
        if norm(r) < tol
            break
        end
        
        Ap = A * p
        p_Ap = dot(p, Ap)
        
        alpha = dot(p, r) / p_Ap
        x .+= alpha .* p
        r .-= alpha .* Ap
        
        push!(res, norm(r))
        
        if norm(r) < tol
            break
        end
        
        beta = -dot(r, Ap) / p_Ap
        p .= r .+ beta .* p
    end
    
    return x, res
end

function kadai3_2()
    plt = plot(title="Kadai3_2",xlabel=L"Iteration ($k$)",ylabel=L"\|r_k\|_2",yscale=:log10,legend=:topright,ylims=(1e-5, 1e1))
    
    for n in [4, 50, 100]
        A, b = Ab(n)
        x_sol, res = cg(A, b)
        iters = length(res) - 1
        println("n = $n: 反復回数 = $iters, 最終残差 = $(res[end])")
        plot!(plt, 0:iters, res, label="n = $n")
    end
    
    save_path = joinpath(homedir(), "Downloads", "kadai3_2.png")
    savefig(plt, save_path)
    return plt
end

kadai3_2()