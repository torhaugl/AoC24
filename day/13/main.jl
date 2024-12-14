
function parse_in()
    data = read("test", String)
    regex = r"Button A: X\+(\d+), Y\+(\d+)\nButton B: X\+(\d+), Y\+(\d+)\nPrize: X=(\d+), Y=(\d+)"
    n = length([m for m in eachmatch(regex, data)])
    out = Matrix{Int}(undef, (n, 6))
    for (i, m) in enumerate(eachmatch(regex, data))
        for j = 1:6
            out[i, j] = parse(Int, m[j])
        end
    end
    return out
end

function part1()
    out = parse_in()
    display(out)
end

part1()
