using Images 

function parse_inp()
    regex = r"p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)"
    lines = collect(readlines("input"))
    A = Matrix{Int}(undef, (length(lines), 4))
    for (i, line) in enumerate(lines)
        m = match(regex, line)
        for j = 1:4
            A[i, j] = parse(Int, m[j])
        end
    end
    return A
end

function move!(A)
    for i = 1:size(A, 1)
        A[i, 1] += A[i, 3]
        A[i, 2] += A[i, 4]
        A[i, 1] = mod(A[i, 1], WIDTH)
        A[i, 2] = mod(A[i, 2], HEIGHT)
    end
end

function safety_factor(A)
    B = zeros((WIDTH, HEIGHT))
    for row in eachrow(A)
        B[row[1]+1, row[2]+1] += 1
    end
    q1 = B[1:WIDTH÷2, 1:HEIGHT÷2]
    q2 = B[1:WIDTH÷2, 2+HEIGHT÷2:end]
    q3 = B[2+WIDTH÷2:end, 1:HEIGHT÷2]
    q4 = B[2+WIDTH÷2:end, 2+HEIGHT÷2:end]
    s1 = round(Int, sum(q1))
    s2 = round(Int, sum(q2))
    s3 = round(Int, sum(q3))
    s4 = round(Int, sum(q4))
    return s1*s2*s3*s4
end

function visualize(A)
    B = zeros(Int, (HEIGHT, WIDTH))
    for row in eachrow(A)
        B[row[2]+1, row[1]+1] += 1
    end
    display(B')
end

using Images

function visualize2(A, i)
    B = zeros((HEIGHT, WIDTH))
    for row in eachrow(A)
        B[row[2]+1, row[1]+1] = 1.0
    end
    save("$i.png", Gray.(B))
end

function part1()
    A = parse_inp()
    for _ = 1:100
        move!(A)
    end
    safety_factor(A)
end

function part2()
    A = parse_inp()
    for i = 1:10000
        move!(A)
        visualize2(A, i)
    end
    println("Manuel inspection of images")
end

WIDTH = 101
HEIGHT = 103
@show part1()
@show part2()
