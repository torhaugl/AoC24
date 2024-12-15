
function parse_in()
    data = read("input", String)
    regex = r"Button A: X\+(\d+), Y\+(\d+)\nButton B: X\+(\d+), Y\+(\d+)\nPrize: X=(\d+), Y=(\d+)"
    n = length([m for m in eachmatch(regex, data)])
    out = Matrix{Rational{BigInt}}(undef, (n, 6))
    for (i, m) in enumerate(eachmatch(regex, data))
        for j = 1:6
            out[i, j] = parse(Rational{BigInt}, m[j])
        end
    end
    return out
end

function isparallel(inp)
    c1 = inp[1] / inp[2]
    c2 = inp[3] / inp[4]
    return c1 == c2
end

function solve_line(inp)
    A = [inp[1] inp[3]; inp[2] inp[4]]
    b = [inp[5]; inp[6]]
    return A\b
end

function solve_line_p2(inp)
    A = [inp[1] inp[3]; inp[2] inp[4]]
    b = [inp[5] + 10000000000000; inp[6] + 10000000000000]
    return A\b
end

function part1()
    out = parse_in()
    println(typeof(out))
    cost = 0
    for line in eachrow(out)
        if isparallel(line)
            continue
        end
        x = solve_line(line)
        if denominator(x[1]) != 1 || denominator(x[2]) != 1
            continue
        end
        if 0 < x[1] <= 100 && 0 < x[2] <= 100
            cost += numerator(3*x[1] + x[2])
        end
    end
    return cost
end

function part2()
    out = parse_in()
    println(typeof(out))
    cost = 0
    for line in eachrow(out)
        if isparallel(line)
            continue
        end
        x = solve_line_p2(line)
        if denominator(x[1]) != 1 || denominator(x[2]) != 1
            continue
        end
        if 0 < x[1] && 0 < x[2]
            cost += numerator(3*x[1] + x[2])
        end
    end
    return cost
end

@show part1()
@show part2()
