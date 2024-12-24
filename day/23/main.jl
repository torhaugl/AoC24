function parse()
    # Bidirectional symmetric graph
    # represented as dictionary
    graph = Dict{String, Set{String}}()
    for line in readlines("test")
        a, b = split(line, '-')
        if a ∉ keys(graph)
            graph[a] = Set{String}()
        end
        push!(graph[a], b)
        if b ∉ keys(graph)
            graph[b] = Set{String}()
        end
        push!(graph[b], a)
    end
    return graph
end

function find_trio(graph)
    trios = []
    for k1 in keys(graph)
        for k2 in graph[k1]
            for k3 in graph[k2]
                if k1 in graph[k3]
                    push!(trios, Set((k1, k2, k3)))
                end
            end
        end
    end
    unique!(trios)
    return trios
end

function part1()
    g = parse()
    trio = find_trio(g)
    t_trio = []
    for v in trio
        for x in v
            if x[1] == 't'
                push!(t_trio, v)
            end
        end
    end
    unique!(t_trio)
    for v in t_trio
        println(v)
    end
    return length(t_trio)
end

function find_group(v, g)
    explored = Set{String}()
    queue = Set{String}()
    recursive_find(v, g, explored, queue)
    @show explored
end

function recursive_find(v, g, explored, queue)
    if v in explored
        return
    end
    push!(explored, v)

    for x in g[v]
        if x ∉ queue
            push!(queue, x)
        end
    end

    for q in queue
        recursive_find(q, g, explored, queue)
    end
end

function part2()
    g = parse()
    groups = find_groups(g)
end

@show part1()

g = parse()
println(g)
find_group("co", g)
