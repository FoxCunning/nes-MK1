--[[
Copyright © 2022–2023 Fox Cunning
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--]]

ROMMap = {start = 0, offset = 0}


function ROMMap:new(start, offset)
    local obj = {}
    setmetatable(obj, self)
    self.start = start
    self.offset = offset
    return obj
end


local function get_label(line)
    local label = 'name="UNDEF"'

    -- Split on commas
    for token in line:gmatch('[^,%s]+') do
        -- Find label
        if (string.find(token, "name=")) then
            label = token:gsub('name=', '')
            break
        end
    end

    -- Only keep what's in the quotes
    return label:gsub('%"', '')
end


local function get_id(line)
    local id = "0"

    for token in line:gmatch('[^,%s]+') do

        if (string.find(token, "id=")) then
            id = token:gsub('id=', '')
            break
        end

    end

    return tonumber(id)
end


local function get_value(line)
    local value = "0"

    -- Split on commas
    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "val=")) then
            value = token:gsub('val=', '')
            break
        end
    end

    return tonumber(value)
end


local function get_addrsize(line)
    local addrsize = "UNKNOWN"

    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "addrsize=")) then
            addrsize = token:gsub('addrsize=', '')
            break
        end
    end

    return addrsize
end


local function get_type(line)
    local type = "UNKNOWN"

    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "type=")) then
            type = token:gsub('type=', '')
            break
        end
    end

    return type
end


local function get_start(line)
    local start = "0"

    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "start=")) then
            start = token:gsub('start=', '')
            break
        end
    end

    return tonumber(start)
end


local function get_offset(line)
    local ofs = "0"

    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "ooffs=")) then
            ofs = token:gsub('ooffs=', '')
            break
        end
    end

    return tonumber(ofs)
end


local function get_seg(line)
    local seg = "-1"

    for token in line:gmatch('[^,%s]+') do
        if (string.find(token, "seg=")) then
            seg = token:gsub('seg=', '')
            break
        end
    end

    return tonumber(seg)
end


--


local map = {}
Output = {}

print("Converting debug symbols...")

local line_no = 0
for line in io.lines("_debug.txt") do

    if line_no == 0 then
        print(line)
    else
        local header = ""
        local pos = line:find('\t')
        
        if (pos ~= nil) then
            header = string.sub(line, 1, pos - 1)
            
            -- SEGMENTS
            if (header == "seg") then
                local name = get_label(line)
                local start = get_start(line)
                if (start == nil) then
                    print("ERROR: No start for segment:", line)
                    break
                end
                local offset = 0
                if (start >= 0x8000) then
                    offset = get_offset(line)
                end

                local id = get_id(line)
                -- table.insert(map, ROMMap:new(start, offset))
                map[id] = ROMMap:new(start, offset)
                map[id].start = start
                map[id].offset = offset
                
                -- print("Found:", header, name, map[id].start, map[id].offset)

            end

            -- SYMBOLS
            if (header == "sym") then
                local name = get_label(line)
                
                -- Skip local symbols
                if (name:sub(1, 1) ~= '@') then
                    -- Find the relative address
                    local address = get_value(line)
                    
                    if (address < 0x8000) then
                        -- RAM label
                        --print("Found RAM label:", name)
                        if (get_type(line) == "equ") then
                            local value = string.format("G:%04X:%s", address, name)
                            -- table.insert(Output, value)
                            Output[value] = true
                        end
                    else
                        -- ROM label
                        --print("Found ROM label:", name)
                        local seg = get_seg(line)
                        
                        if (seg ~= -1 and get_type(line) == "lab") then
                            local file_addr = map[seg].offset + address - map[seg].start
                            local value = string.format("P:%06X:%s", file_addr, name)
                            -- table.insert(Output, value)
                            Output[value] = true
                        end

                    end

                end

            end

        end

    end

    line_no = line_no + 1
end

--[[
for i = 0, #map do
    print(string.format("Seg[%02d]: $%06X - $%06X", i, map[i].start, map[i].offset))
end
--]]

-- Write output file

local out_file = io.open("out/MK1.mlb", "w")
if out_file ~= nil then

    -- Convert set to table, then sort alphabetically
    local out = {}

    for k, _ in pairs(Output) do
        table.insert(out, k)
    end
    table.sort(out)

    for i = 1, #out do
        --print("OUT:", output[i])
        out_file:write(out[i], "\n")
    end

    --[[
    for k,_ in pairs(Output) do
        out_file:write(k, "\n")
    end
--]]

    out_file:close()
end

print("...done!")
