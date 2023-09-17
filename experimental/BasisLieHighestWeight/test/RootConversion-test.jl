using Oscar
using Test

include("../src/RootConversion.jl")
include("../test/RootConversion-test-data.jl")

function test_inverse_alpha_w(dynkin, n, weight)
    lie_type = string(dynkin)
    @test isequal(w_to_alpha(lie_type, n, alpha_to_w(lie_type, n, weight)), weight) # alpha -> w -> alpha
    @test isequal(alpha_to_w(lie_type, n, w_to_alpha(lie_type, n, weight)), weight) # w -> alpha -> w
end 

function test_inverse_eps_w(dynkin, n, weight)
    lie_type = string(dynkin)
    if lie_type in ["A", "G"]
        weight_representative = w_to_eps(lie_type, n, eps_to_w(lie_type, n, weight))
        weight_representative .-= weight_representative[end]
        pop!(weight_representative)
        @test isequal(weight_representative, weight) # eps -> w -> eps
    else
        @test isequal(w_to_eps(lie_type, n, eps_to_w(lie_type, n, weight)), weight) # eps -> w -> eps
    end
    @test isequal(eps_to_w(lie_type, n, w_to_eps(lie_type, n, weight)), weight) # w -> eps -> w
end

function test_inverse_eps_alpha(dynkin, n, weight)
    lie_type = string(dynkin)
    if lie_type in ["A", "G"]
        weight_representative = alpha_to_eps(lie_type, n, eps_to_alpha(lie_type, n, weight))
        weight_representative .-= weight_representative[end]
        pop!(weight_representative)
        @test isequal(weight_representative, weight) # eps -> alpha -> eps
    else
        @test isequal(alpha_to_eps(lie_type, n, eps_to_alpha(lie_type, n, weight)), weight) # eps -> alpha -> eps
    end 
    @test isequal(eps_to_alpha(lie_type, n, alpha_to_eps(lie_type, n, weight)), weight) # alpha -> eps -> alpha
end

@testset "Test RootConversion" begin
    @testset "Dynkin type $dynkin" for dynkin in ('A', 'B', 'C', 'D', 'E', 'F', 'G')
        @testset "n = $n" for n in 1:10
            if (!(dynkin == 'B' && n < 2) && !(dynkin == 'C' && n < 2) && !(dynkin == 'D' && n < 4) 
                && !(dynkin == 'E' && !(n == 6 || n == 7 || n == 8)) && !(dynkin == 'F' && n != 4) 
                && !(dynkin == 'G' && (n != 2)))
                for weight in test_sample_weights[n]
                    print(".")
                    test_inverse_alpha_w(dynkin, n, weight)
                    test_inverse_eps_w(dynkin, n, weight)
                    test_inverse_eps_alpha(dynkin, n, weight)
                end
            end 
        end
    end
end
