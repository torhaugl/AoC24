function is_safe(v)
    diff = [v[i] - v[i+1] for i = 1:length(v)-1]
    safe = all(0 < x <= 3 for x in diff) || all(0 < -x <= 3 for x in diff)
    return safe
end

function is_safe2(vec)
    safe = is_safe(vec)
    for i = 1:length(vec)
        v = vcat(vec[1:i-1], vec[i+1:end])
        @show v
        diff = [v[i] - v[i+1] for i = 1:length(v)-1]
        safe = safe || all(0 < x <= 3 for x in diff) || all(0 < -x <= 3 for x in diff)
    end
    return safe
end

function part1()
    safe = 0
    for line in readlines("input")
        nums = parse.(Int, split(line))
        if is_safe(nums)
            safe += 1
        end
    end
    @show safe
end

function part2()
    safe = 0
    for line in readlines("input")
        nums = parse.(Int, split(line))
        if is_safe2(nums)
            safe += 1
        end
    end
    @show safe
end

part1()
part2()
