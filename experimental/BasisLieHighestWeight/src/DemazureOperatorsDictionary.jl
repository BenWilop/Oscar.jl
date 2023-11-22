# using AbstractAlgebra

include("./RootConversion.jl")

# Original functions (demazure_scalar_prod and demazure_s) remain the same
function demazure_scalar_prod(beta::Int, lambda::Vector{Int})
    return lambda[beta]
end 

function demazure_s(beta::Int, lambda::Vector{Int})
    new_lambda = copy(lambda)
    new_lambda[beta] = 0
    return new_lambda
end

# Function to apply the demazure operator to a lambda vector
function demazure_operator_monom_dictionary(
    beta::Int,
    beta_wi::Vector{Int},
    lambda::Vector{Int}
)
    scalar_prod = demazure_scalar_prod(beta, lambda)
    result = Dict{Vector{Int}, Int}()
    if scalar_prod >= 0
        for i in 0:lambda[beta]
            result[copy(lambda)] = 1
            lambda -= beta_wi
        end
    elseif scalar_prod == -1
        return result
    else
        for i in 0:lambda[beta]
            result[copy(lambda)] = 1
            lambda -= beta_wi
        end
    end
    return result
end

# Function to update the dictionary with the demazure operator
function demazure_operator_dictionary(
    beta::Int,
    beta_wi::Vector{Int},
    dict::Dict{Vector{Int}, Int}
)
    new_dict = Dict{Vector{Int}, Int}()
    for (key, value) in dict
        updated_dict = demazure_operator_monom_dictionary(beta, beta_wi, key)
        for (new_key, new_value) in updated_dict
            new_dict[new_key] = get(new_dict, new_key, 0) + new_value
        end
    end
    return new_dict
end

# Main function to generate the summary using a dictionary
function demazure_operators_summary_dictionary(
    type::String,
    rank::Int,
    lambda::Vector{Int},
    weyl_word::Vector{Int}
)
    # Initialization
    dict = Dict(lambda => 1)

    alpha_wi_list = [alpha_to_w(type, rank, [i == j ? QQ(1) : QQ(0) for i in 1:rank]) for j in 1:rank]
    alpha_wi_list = [Int.(x) for x in alpha_wi_list]

    for alpha_i in reverse(weyl_word)
        dict = demazure_operator_dictionary(alpha_i, alpha_wi_list[alpha_i], dict)
    end

    # Process the dictionary as needed
    # ...
    for (key, value) in result_dict
        println("Lambda: $key, Value: $value")
    end

    return dict
end

# Example usage
type = "A"
rank = 2
lambda = [1, 1]
weyl_word = [1, 2, 1]
result_dict = demazure_operators_summary_dictionary(type, rank, lambda, weyl_word)
