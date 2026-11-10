using Plots

function kadai1_2()
    n = 50
    u = zeros(n+2, n+2)
    
    x = range(0, 1, length=n+2)
    y = range(0, 1, length=n+2)
    
    for i in 1:n+2
        u[i, 1]     = 0.0
        u[i, n+2]   = 50.0 * (1.0 - x[i])^4
        u[1, i]     = 50.0 * y[i]
        u[n+2, i]   = 0.0
    end

    h_start = round(Int, (n+1)/3) + 1
    h_end   = round(Int, 2*(n+1)/3) + 1
    
    for i in h_start:h_end
        for j in h_start:h_end
            u[i, j] = 40.0
        end
    end
    
    maxit = 2000
    tol = 1e-4
    it_end = 0
    final_R = 0.0
    
    for it in 1:maxit
        R = 0.0
        for i in 2:n+1
            for j in 2:n+1
                if h_start <= i <= h_end && h_start <= j <= h_end
                    continue
                end
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
    
    println("Kadai 1-2 反復回数 = $it_end, 最終残差 R = $final_R")
    
    p = surface(x,y,u',xlabel="x",ylabel="y",zlabel="u(x,y)",title="Kadai 1-2",color=:viridis)
    save_path = joinpath(homedir(), "Downloads", "kadai1_2.png")
    savefig(p, save_path)
    return p
end

kadai1_2()