function parse_inp()
    before = true
    wires = Dict{String, Bool}()
    questions = Vector{Tuple{String, String, String, String}}(undef, 0)
    for line in readlines("input")
        if line == ""
            before = false
            continue
        end
        if before
            a, b = split(line, ": ")
            wires[a] = parse(Bool, b)
        else
            a, b, c, d, e = split(line)
            push!(questions, (a, b, c, e))
        end
    end
    return wires, questions
end

function part1()
    wires, questions = parse_inp()
    while !isempty(questions)
        for i = 1:length(questions)
            a, b, c, d = questions[i]
            if a in keys(wires) && c in keys(wires)
                if b == "OR"
                    wires[d] = wires[a] || wires[c]
                elseif b == "XOR"
                    wires[d] = wires[a] ⊻ wires[c]
                elseif b == "AND"
                    wires[d] = wires[a] && wires[c]
                else
                    println("$(c) not recognized")
                end
                deleteat!(questions, i)
                println("Delete $(length(questions))")
                break
            end
        end
    end

    v = collect(wires)
    sort!(v)
    bits = ""
    for (x, y) in v
        if 'z' in x
            println(x)
            if y
                bits = "1" * bits
            else
                bits = "0" * bits
            end
        end
    end
    digit = parse(Int, bits; base=2)
    return digit
end

@show part1()
