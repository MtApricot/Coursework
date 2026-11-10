using Plots

function kadai3_3()
    n = 50
    A, b = Ab(n)
    x_sol, _ = cg(A, b)

    U_inner = reshape(x_sol, n, n)'
    
    U = zeros(n+2, n+2)
    U[2:n+1, 2:n+1] .= U_inner
    
    x_grid = range(0, 1, length=n+2)
    y_grid = range(0, 1, length=n+2)
    
    for i in 1:n+2
        U[i, 1]     = x_grid[i]
        U[i, n+2]   = 1.0 - x_grid[i]
        U[1, i]     = y_grid[i]
        U[n+2, i]   = 1.0 - y_grid[i]
    end
    
    p = surface(x_grid, y_grid, U', xlabel="x", ylabel="y", zlabel="u(x,y)", title="Kadai 3-3", color=:viridis)
    save_path = joinpath(homedir(), "Downloads", "kadai3_3.png")
    savefig(p, save_path)

    for n_val in [4, 50, 100]
        A_val, b_val = Ab(n_val)
        x_cg, _ = cg(A_val, b_val)

        x_direct = A_val \ b_val
        max_err_direct = maximum(abs.(x_cg - x_direct))
        println("n = $n_val: 直接解との最大差 = $max_err_direct")
    end
    
    return p
end

kadai3_3()