using SparseArrays

function Ab(n::Int)
    m = n * n
    A = spzeros(Float64, m, m)
    b = zeros(Float64, m)
    
    x = range(0, 1, length=n+2)
    y = range(0, 1, length=n+2)
    
    idx(i, j) = (i - 1) * n + j
    
    for i in 1:n
        for j in 1:n
            k = idx(i, j)
            A[k, k] = 4.0
            
            if i > 1
                A[k, idx(i-1, j)] = -1.0
            else
                b[k] += y[j+1]
            end
            
            if i < n
                A[k, idx(i+1, j)] = -1.0
            else
                b[k] += (1.0 - y[j+1])
            end
            
            if j > 1
                A[k, idx(i, j-1)] = -1.0
            else
                b[k] += x[i+1]
            end
            
            if j < n
                A[k, idx(i, j+1)] = -1.0
            else
                b[k] += (1.0 - x[i+1])
            end
        end
    end
    return A, b
end

for n_val in [4, 50, 100]
    A_tmp, b_tmp = Ab(n_val)
    println("n = $n_val: 次元数 = $(size(A_tmp,1)), 非ゼロ要素数 (nnz) = $(nnz(A_tmp))")
end