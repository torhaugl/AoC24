mul(x,y) = x*y

function part1()
    mul_regex = r"(mul\(\d+,\d+\))"
    score = 0
    for line in readlines("input")
        println("line")
        for m in getfield.(eachmatch(mul_regex, line), :match)
            @show m
            score += eval(Meta.parse(m))
        end
    end
    @show score
end

function part2()
    mul_regex = r"(mul\(\d+,\d+\))|(don't\(\))|(do\(\))"
    score = 0
    enable = true
    for line in readlines("input")
        println("line")
        for m in getfield.(eachmatch(mul_regex, line), :match)
            if string(m) == "don't()"
                enable = false
            elseif string(m) == "do()"
                enable = true
            else
                @show m
                if enable
                    score += eval(Meta.parse(m))
                end
            end
        end
    end
    @show score
end

part1()
part2()
