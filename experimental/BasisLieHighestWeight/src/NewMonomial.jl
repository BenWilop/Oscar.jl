function weight(mon::ZZMPolyRingElem, weights_w::Vector{Vector{ZZRingElem}})
  @assert length(weights_w) == length(degrees(mon))
  return sum(exp * weight for (exp, weight) in zip(degrees(mon), weights_w))
end

function calc_vec(
  v0::SRow{ZZRingElem},
  mon::ZZMPolyRingElem,
  matrices_of_operators::Vector{<:SMat{ZZRingElem}},
)
  v = v0
  degree_mon = degrees(mon)
  for i in length(degree_mon):-1:1
    for _ in 1:degree_mon[i]
      # v = v * transpose(matrices_of_operators[i])
      v = v * matrices_of_operators[i]
    end
  end
  return v
end
