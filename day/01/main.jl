as = []
bs = []
for line in readlines("input")
    nums = split(line, "   ")
    a = parse(Int, nums[1])
    append!(as, a)
    b = parse(Int, nums[2])
    append!(bs, b)
end
sort!(as)
@show as
sort!(bs)
dist = sum(abs.(as .- bs))
@show dist

function count(v)
    cnt = Dict()
    for x in v
        cnt[x] = get(cnt, x, 0) + 1
    end
    return cnt
end

count_a = count(as)
count_b = count(bs)

function part2()
    score = 0
    for k in keys(count_a)
        score += k * count_a[k] * get(count_b, k, 0)
        @show score
    end
    return score
end
@show part2()
