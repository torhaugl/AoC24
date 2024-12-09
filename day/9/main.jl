function filesystem_checksum(filesystem :: String)
    checksum = 0
    for (i, c) in enumerate(filesystem)
        if c == '.'
            continue
        end
        checksum += (i-1) * parse(Int, c)
    end
    return checksum
end

@assert filesystem_checksum("0099811188827773336446555566..............") == 1928

function diskmap_to_filesystem(diskmap)
    filesystem = ""
    for (i, c) in enumerate(diskmap)
        num = parse(Int, c)
        if (mod(i, 2) == 1)
            for _ = 1:num
                filesystem *= string(div(i, 2))
            end
        else
            for _ = 1:num
                filesystem *= '.'
            end
        end
    end
    filesystem
end

function move_left(str)
    index_dot = findfirst(==('.'), str)
    index_num = findlast(isnumeric, str)
    new_str = str[1:index_dot-1] * str[index_num]
    new_str *= str[index_dot+1:index_num-1] * '.' * str[index_num+1:end]
    new_str
end

str = "0..111....22222"
new_str = move_left(str)
true_str = "02.111....2222."
@assert new_str == true_str

str = "02.111....2222."
new_str = move_left(str)
true_str = "022111....222.."
@assert new_str == true_str

str = "022111....222.."
new_str = move_left(str)
true_str = "0221112...22..."
@assert new_str == true_str

function amphipod_filesystem(filesystem)
    filesystem_new = move_left(filesystem)
    while filesystem_new != filesystem
        filesystem = filesystem_new
        filesystem_new = move_left(filesystem)
    end
    return filesystem
end

@assert diskmap_to_filesystem("12345") == "0..111....22222"
@assert diskmap_to_filesystem("2333133121414131402") == "00...111...2...333.44.5555.6666.777.888899"
@show diskmap_to_filesystem("111111111111111111111")

function part1()
    line = strip(read("day/9/input", String))
    diskmap = [c for c in line]
    filesystem = diskmap_to_filesystem(diskmap)
    println(filesystem[1:20])
    filesystem = amphipod_filesystem(filesystem)
    println(filesystem[1:20])
    checksum = filesystem_checksum(filesystem)
    return checksum
end

@show part1()
