using Plots

function kadai1_1()
    n = 50
    u = zeros(n+2, n+2)
    
    x = range(0, 1, length=n+2)
    y = range(0, 1, length=n+2)
    
    for i in 1:n+2
        u[i, 1]     = sin(pi * x[i])
        u[i, n+2]   = 0.0
        u[1, i]     = 0.0
        u[n+2, i]   = sin(pi * y[i])
    end
    
    maxit = 2000
    tol = 1e-4
    it_end = 0
    final_R = 0.0
    
    for it in 1:maxit
        R = 0.0
        for i in 2:n+1
            for j in 2:n+1
                r = (u[i+1, j] + u[i-1, j] + u[i, j+1] + u[i, j-1]) / 4.0 - u[i, j]
                u[i, j] += r
                R = max(R, abs(r))
            end
        end
        it_end = it
        final_R = R
        if R <= tol
            break
        end
    end
    
    println("Kadai1-1 反復回数 = $it_end, 最終残差 R = $final_R")
    
    p = surface(x,y,u',xlabel="x",ylabel="y",zlabel="u(x,y)",title="Kadai1-1",color=:viridis)
    save_path = joinpath(homedir(), "Downloads", "kadai1_1.png")
    savefig(p, save_path)
    return p
end

kadai1_1()