function filesystem_checksum(filesystem)
    checksum = 0
    for (i, c) in enumerate(filesystem)
        if c == -1
            continue
        end
        checksum += (i-1) * c
    end
    return checksum
end

# @assert filesystem_checksum("0099811188827773336446555566..............") == 1928

function diskmap_to_filesystem(diskmap)
    filesystem = Vector{Int}(undef, 0)
    for (i, c) in enumerate(diskmap)
        num = parse(Int, c)
        if (mod(i, 2) == 1)
            for _ = 1:num
                push!(filesystem, div(i, 2))
            end
        else
            for _ = 1:num
                push!(filesystem, -1)
            end
        end
    end
    filesystem
end

function move_left!(v)
    index_dot = findfirst(==(-1), v)
    index_num = findlast(!=(-1), v)
    v[index_dot] = v[index_num]
    v[index_num] = -1
end

#str = "0..111....22222"
#new_str = move_left(str)
#true_str = "02.111....2222."
#@assert new_str == true_str
#
#str = "02.111....2222."
#new_str = move_left(str)
#true_str = "022111....222.."
#@assert new_str == true_str
#
#str = "022111....222.."
#new_str = move_left(str)
#true_str = "0221112...22..."
#@assert new_str == true_str

function amphipod_filesystem!(filesystem)
    filesystem_new = copy(filesystem)
    index_dot = 0
    index_num = 1
    while index_num > index_dot
        filesystem = filesystem_new
        move_left!(filesystem_new)
        index_dot = findfirst(==(-1), filesystem_new)
        index_num = findlast(!=(-1), filesystem_new)
    end
    filesystem = filesystem_new
    filesystem
end

#@show diskmap_to_filesystem("11111111111111111111111")
#@assert diskmap_to_filesystem("12345") == "0..111....22222"
#@assert diskmap_to_filesystem("2333133121414131402") == "00...111...2...333.44.5555.6666.777.888899"

function part1()
    diskmap = strip(read("day/9/input", String))
    filesystem = diskmap_to_filesystem(diskmap)
    println(filesystem[1:20])
    filesystem = amphipod_filesystem!(filesystem)
    println(filesystem[1:20])
    checksum = filesystem_checksum(filesystem)
    return checksum
end

@show part1()
