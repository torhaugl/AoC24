
"""
To mix a value into the secret number, calculate the bitwise XOR of the given value and the secret number.
Then, the secret number becomes the result of that operation.
(If the secret number is 42 and you were to mix 15 into the secret number, the secret number would become 37.)
"""
mix(secret::Int, result::Int) = xor(secret, result)
@assert mix(42, 15) == 37

"""
To prune the secret number, calculate the value of the secret number modulo 16777216.
Then, the secret number becomes the result of that operation.
"""
prune(secret) = mod(secret, 16777216)
@assert prune(100000000) == 16113920

function secret(s::Int)
    x = s
    # Calculate the result of multiplying the secret number by 64. 
    # Then, mix this result into the secret number. 
    # Finally, prune the secret number.
    result = x * 64
    x = mix(x, result)
    x = prune(x)
    result = x ÷ 32
    x = mix(x, result)
    x = prune(x)
    result = x * 2048
    x = mix(x, result)
    x = prune(x)
    return x
end

function test_secret()
    ref = [15887950, 16495136, 527345, 704524, 1553684, 12683156, 11100544,
        12249484, 7753432, 5908254]
    x = 123
    for r in ref
        x = secret(x)
        @assert x == r
    end
end
test_secret()

function secret_n(x, n)
    s = x
    for _ = 1:n
        s = secret(s)
    end
    return s
end

function test_secret_n()
    ref = Dict(1 => 8685429, 10 => 4700978, 100 => 15273692, 2024 => 8667524)
    for (k, v) in ref
        @assert secret_n(k, 2000) == v
    end
end
test_secret_n()

function part1()
    score = 0
    for line in readlines("input")
        x = parse(Int, line)
        score += secret_n(x, 2000)
    end
    return score
end
@show part1()

function price(x::Int)
    # the prices the buyer offers are just the ones digit of each of their secret numbers.
    # Add 0.1 to avoid numerical noise if floor
    y = floor(Int, x / 10) * 10
    return x - y
end
@assert price(123) == 3

function all_secret_n(x, n)
    y = zeros(Int, n)
    s = x
    for i in eachindex(y)
        y[i] = price(s)
        s = secret(s)
    end
    return y
end
@assert all_secret_n(123, 10) == [3, 0, 6, 5, 4, 4, 6, 4, 4, 2]

function diff_price(y)
    z = zeros(Int, length(y))
    # Impossible in list, cannot match later
    z[1] = 10
    for i in 2:length(z)
        z[i] = y[i] - y[i-1]
    end
    return z
end
@assert diff_price([3, 0, 6, 5, 4, 4, 6, 4, 4, 2]) == [10, -3, 6, -1, -1, 0, 2, -2, 0, -2]

function get_score2(y, z, nums)
    score = 0
    for i = 2:length(z)-3
        if z[i:i+3] == nums
            score = y[i+3]
            # find first only, so break here
            break
        end
    end
    return score
end
#@assert get_score2(1, [-2, 1, -1, 3]) == 7
#@assert get_score2(2, [-2, 1, -1, 3]) == 7
#@assert get_score2(3, [-2, 1, -1, 3]) == 0
#@assert get_score2(2024, [-2, 1, -1, 3]) == 9

function part2()
    max_score = 0
    best_ijkl = [-9, -9, -9, -9]
    xs = []
    ys = []
    zs = []
    for line in readlines("input")
        x = parse(Int, line)
        push!(xs, x)
        y = all_secret_n(x, 2000)
        push!(ys, y)
        z = diff_price(y)
        push!(zs, z)
    end

    Threads.@threads for i = -9:9
        ijkl = [0, 0, 0, 0]
        # Assume l > 0 for maximum score
        for j = -9:9, k = -9:9, l = 1:9
            # Simple screening
            if abs(i + j + k + l) > 9
                continue
            elseif abs(i + j + k) > 9
                continue
            elseif abs(j + k + l) > 9
                continue
            elseif abs(i + j) > 9
                continue
            elseif abs(j + k) > 9
                continue
            elseif abs(k + l) > 9
                continue
            end

            ijkl[1] = i
            ijkl[2] = j
            ijkl[3] = k
            ijkl[4] = l

            score = 0
            for (y, z) in zip(ys, zs)
                score += get_score2(y, z, ijkl)
            end
            if score > max_score
                max_score = max(max_score, score)
                best_ijkl[1] = i
                best_ijkl[2] = j
                best_ijkl[3] = k
                best_ijkl[4] = l
            end
        end
    end
    return max_score, best_ijkl
end
@show part2()
