input = """89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732"""

function part1()
    matrix = Matrix{Int}(undef, (8, 8))
    for (i, line) in enumerate(readlines("day/10/test"))
        for (j, c) in enumerate(line)
            matrix[i,j] = parse(Int, c)
        end
    end

    spearheads = findall(==(0), matrix)
    for s in spearheads
        println(s)
    end
end

@show part1()
