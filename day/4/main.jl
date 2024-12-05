function parse(fname)
    data = split(read(fname, String), '\n')
    nrows = length(data) - 1
    ncols = length(data[1])

    matrix = Matrix{Char}(undef, (nrows, ncols))
    for i = 1:nrows, j = 1:ncols
        matrix[i, j] = data[i][j]
    end
    return matrix
end

function part1()
    matrix = parse("day/3/input")
    score = 0
    for row in eachrow(matrix)
        for i = 1:length(row)-3
            if join(row[i:i+3]) == "XMAS"
                score += 1
            end
            if join(row[i:i+3]) == "SAMX"
                score += 1
            end
        end
    end
    for col in eachcol(matrix)
        for i = 1:length(col)-3
            if join(col[i:i+3]) == "XMAS"
                score += 1
            end
            if join(col[i:i+3]) == "SAMX"
                score += 1
            end
        end
    end
    for i = 1:size(matrix, 1)-3, j = 1:size(matrix, 2)-3
        str = join(matrix[i+x, j+x] for x = 0:3)
        if str == "XMAS"
            score += 1
        end
        if str == "SAMX"
            score += 1
        end
        str = join(matrix[i+x, j+3-x] for x = 0:3)
        if str == "XMAS"
            score += 1
        end
        if str == "SAMX"
            score += 1
        end
    end
    return score
end

function part2()
    matrix = parse("day/3/input")
    # Optional (debugging purposes)
    matrix_mas = similar(matrix)
    matrix_mas .= '.'

    score = 0
    for i = 1:size(matrix, 1)-2, j = 1:size(matrix, 2)-2
        str1 = join(matrix[i+x, j+x] for x = 0:2)
        str2 = join(matrix[i+x, j+2-x] for x = 0:2)
        if (str1 == "MAS" || str1 == "SAM") && (str2 == "MAS" || str2 == "SAM")
            score += 1

            # Optional (debugging purposes)
            matrix_mas[i, j] = str1[1]
            matrix_mas[i+1, j+1] = str1[2]
            matrix_mas[i+2, j+2] = str1[3]
            matrix_mas[i, j+2] = str2[1]
            matrix_mas[i+1, j+1] = str2[2]
            matrix_mas[i+2, j+0] = str2[3]
        end
    end
    return score
end

@show part1()
@show part2()
