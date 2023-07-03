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

-- Constants

CMD_REST = 0
CMD_HOLD = 1
CMD_CALL = 0xF0
CMD_RETURN = 0xF1
CMD_NOTE_DELAY = 0xF2   -- TODO
CMD_DELAYED_CUT = 0xF3  -- TODO
CMD_JUMP = 0xF4
CMD_SPEED = 0xF5
CMD_TRANSPOSE = 0xF6    -- Change to delayed transpose
CMD_SKIP = 0xF7         -- TODO
CMD_VOL_ENV = 0xF8
CMD_DUT_ENV = 0xF9
CMD_PIT_ENV = 0xFA
CMD_SET_ARP = 0xFB
CMD_NOTE_SLIDE = 0xFC   -- TODO
-- 0xFD
-- 0xFE
CMD_END = 0xFF

-- Global variables

Speed = 1
Instruments = {}
Lines = {}
Order = {}

Channels = {}
-- This is for clarity
Channels[0] = {} -- Square Wave 0
Channels[0].name = "SQUARE WAVE 0"
Channels[1] = {} -- Square Wave 1
Channels[1].name = "SQUARE WAVE 1"
Channels[2] = {} -- Triangle Wave
Channels[2].name = "TRIANGLE WAVE"
Channels[3] = {} -- Noise
Channels[3].name = "        NOISE"
Channels[4] = {} -- DPCM
Channels[4].name = "DELTA MODULATION"
for c = 0, 4 do
    Channels[c].patterns = {}
end

-------------------------------------------------------------------------------

-- Table used to convert a note name to its index (e.g. "D-1" -> 0x0E)

Notes = {}

Notes["..."] = 0xFE
Notes["---"] = CMD_REST

-- Special "note hold" event
Notes["HOL"] = CMD_HOLD

-- This could be done in a loop, but IT would be less readable

Notes["A-0"] = 0x09
Notes["A#0"] = 0x0A
Notes["B-0"] = 0x0B

Notes["C-1"] = 0x0C
Notes["C#1"] = 0x0D
Notes["D-1"] = 0x0E
Notes["D#1"] = 0x0F
Notes["E-1"] = 0x10
Notes["F-1"] = 0x11
Notes["F#1"] = 0x12
Notes["G-1"] = 0x13
Notes["G#1"] = 0x14
Notes["A-1"] = 0x15
Notes["A#1"] = 0x16
Notes["B-1"] = 0x17

Notes["C-2"] = 0x18
Notes["C#2"] = 0x19
Notes["D-2"] = 0x1A
Notes["D#2"] = 0x1B
Notes["E-2"] = 0x1C
Notes["F-2"] = 0x1D
Notes["F#2"] = 0x1E
Notes["G-2"] = 0x1F
Notes["G#2"] = 0x20
Notes["A-2"] = 0x21
Notes["A#2"] = 0x22
Notes["B-2"] = 0x23

Notes["C-3"] = 0x24
Notes["C#3"] = 0x25
Notes["D-3"] = 0x26
Notes["D#3"] = 0x27
Notes["E-3"] = 0x28
Notes["F-3"] = 0x29
Notes["F#3"] = 0x2A
Notes["G-3"] = 0x2B
Notes["G#3"] = 0x2C
Notes["A-3"] = 0x2D
Notes["A#3"] = 0x2E
Notes["B-3"] = 0x2F

Notes["C-4"] = 0x30
Notes["C#4"] = 0x31
Notes["D-4"] = 0x32
Notes["D#4"] = 0x33
Notes["E-4"] = 0x34
Notes["F-4"] = 0x35
Notes["F#4"] = 0x36
Notes["G-4"] = 0x37
Notes["G#4"] = 0x38
Notes["A-4"] = 0x39
Notes["A#4"] = 0x3A
Notes["B-4"] = 0x3B

Notes["C-5"] = 0x3C
Notes["C#5"] = 0x3D
Notes["D-5"] = 0x3E
Notes["D#5"] = 0x3F
Notes["E-5"] = 0x40
Notes["F-5"] = 0x41
Notes["F#5"] = 0x42
Notes["G-5"] = 0x43
Notes["G#5"] = 0x44
Notes["A-5"] = 0x45
Notes["A#5"] = 0x46
Notes["B-5"] = 0x47

Notes["C-6"] = 0x48
Notes["C#6"] = 0x49
Notes["D-6"] = 0x4A
Notes["D#6"] = 0x4B
Notes["E-6"] = 0x4C
Notes["F-6"] = 0x4D
Notes["F#6"] = 0x4E
Notes["G-6"] = 0x4F
Notes["G#6"] = 0x50
Notes["A-6"] = 0x51
Notes["A#6"] = 0x52
Notes["B-6"] = 0x53

Notes["C-7"] = 0x54
Notes["C#7"] = 0x55
Notes["D-7"] = 0x56
Notes["D#7"] = 0x57
Notes["E-7"] = 0x58
Notes["F-7"] = 0x59
Notes["F#7"] = 0x5A
Notes["G-7"] = 0x5B
Notes["G#7"] = 0x5C
Notes["A-7"] = 0x5D
Notes["A#7"] = 0x5E
Notes["B-7"] = 0x5F

-- Noise channel

Notes["F-#"] = 0x00
Notes["E-#"] = 0x01
Notes["D-#"] = 0x02
Notes["C-#"] = 0x03
Notes["B-#"] = 0x04
Notes["A-#"] = 0x05
Notes["9-#"] = 0x06
Notes["8-#"] = 0x07
Notes["7-#"] = 0x08
Notes["6-#"] = 0x09
Notes["5-#"] = 0x0A
Notes["4-#"] = 0x0B
Notes["3-#"] = 0x0C
Notes["2-#"] = 0x0D
Notes["1-#"] = 0x0E
Notes["0-#"] = 0x0F

-- These tables are used to easily find note names
Note_Names = { "HOLD", "*INVALID*", "*INVALID*", "*INVALID*", "*INVALID*", "*INVALID*", "*INVALID*", "*INVALID*",
    "A-0", "A#0", "B-0",
    "C-1", "C#1", "D-1", "D#1", "E-1", "F-1", "F#1", "G-1", "G#1", "A-1", "A#1", "B-1",
    "C-2", "C#2", "D-2", "D#2", "E-2", "F-2", "F#2", "G-2", "G#2", "A-2", "A#2", "B-2",
    "C-3", "C#3", "D-3", "D#3", "E-3", "F-3", "F#3", "G-3", "G#3", "A-3", "A#3", "B-3",
    "C-4", "C#4", "D-4", "D#4", "E-4", "F-4", "F#4", "G-4", "G#4", "A-4", "A#4", "B-4",
    "C-5", "C#5", "D-5", "D#5", "E-5", "F-5", "F#5", "G-5", "G#5", "A-5", "A#5", "B-5",
    "C-6", "C#6", "D-6", "D#6", "E-6", "F-6", "F#6", "G-6", "G#6", "A-6", "A#6", "B-6",
    "C-7", "C#7", "D-7", "D#7", "E-7", "F-7", "F#7", "G-7", "G#7", "A-7", "A#7", "B-7",
}
Note_Names[0] = "REST"

Noise_Names = { "E-#", "D-#", "C-#", "B-#", "A-#", "9-#", "8-#",
    "7-#", "6-#", "5-#", "4-#", "3-#", "2-#", "1-#", "0-#",
}
Noise_Names[0] = "REST"

-------------------------------------------------------------------------------


-- Splits a space-separated string

local function split_spaces(text)
    local split = {}

    for s in text:gmatch("%S+") do
        split[#split + 1] = s
    end
    
    return split
end

-------------------------------------------------------------------------------


-- Splits a colon-separated string

local function split_row(text)
    local split = {}
    for s in text:gmatch("[^:]+") do
        split[#split + 1] = s
    end

    return split
end

-------------------------------------------------------------------------------


-- Returns true if channel cn contains the effect of type ft in pattern pn, row rn

local function contains_fx(cn, pn, rn, ft)
    for fn = 1, #Channels[cn].patterns[pn].rows[rn].fx do
        local fx = Channels[cn].patterns[pn].rows[rn].fx[fn]

        if fx[0] == ft then return true end
    end

    return false
end

-------------------------------------------------------------------------------


-- Converts a line of text to instrument data

local function new_instrument(text)
    -- print(string.format("***DEBUG Converting instrument data: %s", text))
    local ins = {}

    local values = split_spaces(text)
    ins.id = tonumber(values[2])
    if ins.id < 0 then ins.id = 0xFF end
    ins.vol = tonumber(values[3])
    if ins.vol < 0 then ins.arp = 0xFF end
    ins.arp = tonumber(values[4])
    if ins.arp < 0 then ins.arp = 0xFF end
    ins.pit = tonumber(values[5])
    if ins.pit < 0 then ins.pit = 0xFF end
    ins.dut = tonumber(values[7])
    if ins.dut < 0 then ins.dut = 0xFF end

    local n = text:find('"', 1, false)
    if n ~= nil then
        ins.name = text:sub(n)
    else
        ins.name = "(blank)"
    end

    return ins
end

-------------------------------------------------------------------------------

-- Converts a line of text to row data
-- The parameter should be a single "cell" (one channel), not the whole row

local function new_row(text)
    local row = {}
    local split = split_spaces(text)

    -- Read note
    local note = split[1]
    -- Turn note name into index
    row.note = Notes[note]
    if row.note == nil then
        print(string.format("!!!WARNING: Invalid note '%s' in row: %s", note, text))
    end

    -- Read instrument
    if split[2] == ".." then
        row.vol_env = 0xFF
        row.arp = 0xFF
        row.pit_env = 0xFF
        row.dut_env = 0xFF
        row.inst = "None"
    else
        local inst = tonumber(split[2], 16)
        if inst == nil or inst < 0 or inst > #Instruments then
            inst = -1
            print(string.format("!!!WARNING: Invalid instrument %d in row: %s", inst, text))
        end
        -- Turn instrument into envelope indices
        row.vol_env = Instruments[inst].vol
        row.arp = Instruments[inst].arp
        row.pit_env = Instruments[inst].pit
        row.dut_env = Instruments[inst].dut
        row.inst = Instruments[inst].name
    end
    
    -- Ignore volume

    -- Read effects
    local fx = {}
    for f = 4, #split do
        fx[#fx + 1] = split[f]
    end
    row.fx = fx

    -- If there is no note, but there is an effect, add a "hold" event
    if split[1] == "..." and row.fx[1] ~= "..." then
        row.note = 1
    end

    return row
end

-------------------------------------------------------------------------------

-- Convers a FamiTracker effect to command id and ASM code, e.g.:
-- Parameter = "T07", Output = 0xF5, "\t.byte $F5, $07;t Speed=7\n"
-- If a command has no parameters, the second value will be nil

local function convert_fx(text)
    local cmd = -1
    local p1 = nil
    local p2 = nil
    local name = ""
    local asm = "\n"
    local fx = text:sub(1, 1)

    if fx == 'F' then
        
        cmd = CMD_SPEED
        p1 = tonumber(text:sub(2, 3), 16)
        name = "SPEED"

    elseif fx == 'D' then

        cmd = CMD_SKIP
        name = "SKIP"

    elseif fx == 'G' then

        cmd = CMD_NOTE_DELAY
        p1 = tonumber(text:sub(2, 3), 16)
        name = "NOTE DELAY"

    elseif fx == 'S' then

        cmd = CMD_DELAYED_CUT
        p1 = tonumber(text:sub(2, 3), 16)
        name = "DELAYED CUT"

    elseif fx == 'Q' then

        cmd = CMD_NOTE_SLIDE
        p1 = tonumber(text:sub(2, 3), 16)
        name = "NOTE SLIDE UP"

    elseif fx == 'T' then

        cmd = CMD_TRANSPOSE
        p1 = tonumber(text:sub(2, 3), 16)
        p2 = (p1 & 0x0F)

        if (p1 & 0x80) ~= 0 then
            -- Negative transpoose
            p2 = 0x100 - p2
        end

        p1 = (p1 & 0x70) >> 4

        name = "TRANSPOSE"

    else

        print(string.format("!!!WARNING: Unimplemented/unrecognised effect: %s", text))

    end

    if cmd ~= -1 then
        asm = string.format("\t.byte $%02X", cmd)

        if p1 ~= nil then
            asm = asm .. string.format(", $%02X", p1)
        end

        if p2 ~= nil then
            asm = asm .. string.format(", $%02X", p2)
        end

        asm = asm .. "\t; " .. name

        if p1 ~= nil then
            asm = asm .. " = " .. p1
        end

        if p2 ~= nil then
            asm = asm .. ", " .. p2
        end

        asm = asm .. "\n"
    end

    return cmd, asm
end

-------------------------------------------------------------------------------


-- Converts a line of text to order data

local function new_order(text)
    local ord = {}
    local split = split_spaces(text)

    ord.id = tonumber(split[2], 16)
    ord.patterns = {}
    -- One pattern index per channel
    ord.patterns[0] = tonumber(split[4], 16)
    ord.patterns[1] = tonumber(split[5], 16)
    ord.patterns[2] = tonumber(split[6], 16)
    ord.patterns[3] = tonumber(split[7], 16)
    ord.patterns[4] = tonumber(split[8], 16)

    return ord
end

-------------------------------------------------------------------------------


-- Parse instruments block

local function read_instruments()
    print("Reading instrument definitions...")

    local ln = 0

    -- Look for start of instruments block
    for line = 1, #Lines do
        if Lines[line]:sub(1, 7) == "# INSTR" then
            ln = line
            break
        end
    end

    if ln > 0 then
        -- print(string.format("***DEBUG: Found instruments block at line %d.", ln))

        for line = ln+1, #Lines do
            local text = Lines[line]
            if text == nil or text == "\n" or text:sub(1, 1) == "#" then
                --- End of block
                -- print(string.format("***DEBUG End of instruments block at line %d.", line))
                break
            end

            if text:sub(1, 8) == "INST2A03" then
                -- Found instrument definition
                local ins = new_instrument(text)
                Instruments[tonumber(ins.id)] = ins
            end
        end

        return
    end

    print("!!!ERROR: Could not find INSTRUMENTS block.")
end

-------------------------------------------------------------------------------

-- Reads all rows for the given track

local function read_rows(title)
    local start = 0

    -- Hunt for the title
    for ln = 1, #Lines do
        local line = Lines[ln]

        if line:sub(1, 5) == "TRACK" then
            -- Found a track, compare title to see if it's the one we need
            local n = line:find('"', 1, false)
            -- print(string.format("***DEBUG: Found '%s'...", line:sub(n + 1, -2)))
            if line:sub(n + 1, -2) == title then
                start = ln + 1
                break
            end
        end
    end

    if start > 0 then
        -- Read track speed
        local line = split_spaces(Lines[start - 1])
        Speed = tonumber(line[3])
        print(string.format("\01 Importing track '%s' with speed=%d \01", title, Speed))
    else
        print(string.format("!!!ERROR: Could not find track '%s'.", title))
        return
    end

    -- Read number of columns per channel
    for ln = start, #Lines do
        local line = Lines[ln]

        if line == nil or line == "\n" or line:sub(1, 1) == "#" then
            -- Start of new block found before "COLUMNS"
            print("!!!ERROR: Could not find COLUMNS definition.")
            return
        end

        if line:sub(1, 7) == "COLUMNS" then
            -- Five values follow, one per channel, indicating how many effects per row
            local split = split_spaces(line:sub(11))
            Channels[0].columns = tonumber(split[1])
            Channels[1].columns = tonumber(split[2])
            Channels[2].columns = tonumber(split[3])
            Channels[3].columns = tonumber(split[4])
            Channels[4].columns = tonumber(split[5])

            -- This is where to start looking for ORDER definitions
            start = ln + 3
            break
        end
    end
    
    -- Read frames block (order)
    for ln = start, #Lines do
        local line = Lines[ln]

        if line == nil or line == "\n" or line:sub(1, 1) == "#" then
            -- End of FRAMES block
            start = ln + 1
            break
        end

        if line:sub(1, 5) == "ORDER" then
            local o = new_order(line)
            Order[o.id] = o
        end
    end

    --[[
    for o = 0, #Order do
        print(string.format("***DEBUG: Order[%02X]: %02X, %02X, %02X, %02X, %02X",
            Order[o].id, Order[o].patterns[0], Order[o].patterns[1], Order[o].patterns[2],
            Order[o].patterns[3], Order[o].patterns[4]))
    end
    --]]

    -- Read pattern data
    local p = -1 -- Current pattern index
    
    -- Temporary patterns, one per channel
    local pattern = {}
    for pn = 0, 4 do
        pattern[pn] = {}
        pattern[pn].rows = {}
    end

    for ln = start, #Lines do
        local line = Lines[ln]
        -- print(string.format("***DEBUG: Reading row %d: %s", ln, line))

        if line == nil or line == "\n" or line:sub(1, 1) == "#" then
            -- End of rows
            break
        end

        if line:sub(1, 7) == "PATTERN" then
            -- "Save" current pattern
            Channels[0].patterns[p] = pattern[0]
            Channels[1].patterns[p] = pattern[1]
            Channels[2].patterns[p] = pattern[2]
            Channels[3].patterns[p] = pattern[3]
            Channels[4].patterns[p] = pattern[4]

            -- Move to next pattern
            p = p + 1
            for pn = 0, 4 do
                pattern[pn] = {}
                pattern[pn].rows = {}
            end
            
        elseif line:sub(1, 3) == "ROW" then

            -- Read row data
            local split = split_row(line)
            local row_id = tonumber(split[1]:sub(5), 16)

            -- local row = new_row(split[2])
            -- print(string.format("**DEBUG: Row data - %02X (%s), %d, %d, %d, %d, %s",
            --     row.note, row.inst, row.dut_env, row.arp, row.pit_env, row.dut_env, row.fx[1]))

            -- Easier to debug when it's unrolled
            pattern[0].rows[row_id] = new_row(split[2])
            pattern[1].rows[row_id] = new_row(split[3])
            pattern[2].rows[row_id] = new_row(split[4])
            pattern[3].rows[row_id] = new_row(split[5])
            pattern[4].rows[row_id] = new_row(split[6])
            
        end
    end

    -- Now we need to calculate note duration

    for cn = 4, 0, -1 do

        for pn = 0, #Channels[cn].patterns do

            pattern = Channels[cn].patterns[pn]

            -- If the first row of a pattern does not have a note, hold or rest, then add a rest there
            if pattern.rows[0].note == 0xFE then
                pattern.rows[0].note = CMD_HOLD
            end

            for rn = 0, #pattern.rows do
                local row = pattern.rows[rn]

                -- Move all speed effects to channel 0
                if cn > 0 then
                    -- Hunt for speed effects
                    for fn = 1, #row.fx do
                        local fx = row.fx[fn]

                        if fx[1] == 'F' then
                            -- When a Speed effect is found (Fxx) on any channel:
                            -- Check if Channel 0 already had a Txx event on that row
                            if contains_fx(0, pn, rn, 'F') == false then
                                -- If not, add it there
                                table.insert(Channels[0].patterns[pn].row[rn].fx, fx[1])
                            end
                        end
                    end
                end

                -- Add a "hold note" command on rows that have effects but no note or rest
                if row.note == 0xFE and row.fx[1] ~= "..." then
                    -- If no note, rest or hold found, but there is an effect, then create a note hold
                    row.note = CMD_HOLD
                end

                if row.note >= CMD_REST and row.note <= 0x5F then
                    -- When a note, rest or hold is found, count how many rows before the next,
                    -- and use that at note duration

                    local duration = 1

                    for look_ahead = rn + 1, #pattern.rows do
                        if (pattern.rows[look_ahead].note >= 0 and pattern.rows[look_ahead].note <= 0x5F)
                            or pattern.rows[look_ahead].fx[1] ~= "..." then
                            break
                        end
                        duration = duration + 1
                    end
                    
                    row.duration = duration
                end
                
            end

        end

    end

    --[[ DEBUG dump
    local dbg = io.open("debug.txt", "w")
    if dbg == nil then return end
    for cn = 0, 4 do
        local channel = Channels[cn]

        dbg:write(string.format("\nChannel %d\n\n", cn))

        for pn = 0, #channel.patterns do
            pattern = channel.patterns[pn]

            dbg:write(string.format("Pattern %02X\n", pn))

            for rn = 0, #pattern.rows do
                local row = pattern.rows[rn]
                if row == nil then
                    print(string.format("!!!ERROR: Channel %d, pattern %d, row %d does not exist!",
                            cn, pn, rn))
                else
                    dbg:write(string.format("Row[%02X]:\t%02X (len=%d) (inst=%s)\t",
                            rn, row.note, (row.duration or 0), (row.inst or "")))
                    for fn = 1, #row.fx do
                        dbg:write(string.format("%s ", row.fx[fn]))
                    end
                    dbg:write("\n")
                end
            end

        end

    end
    dbg:close()
    --]]

end

-------------------------------------------------------------------------------


-- Parse arguments

if #arg < 3 then
    print("Usage: " .. arg[0] .. " <input file.txt> <output file.asm> <track name|-i|--instruments> [-l|--loop]")
    os.exit(1)
end

local input_file_name = arg[1]
local output_file_name = arg[2]
local export_instruments = false
local track_name = ""
local loop_frame_0 = false

if output_file_name:find(".", 1, true) == nil then
    output_file_name = output_file_name .. ".asm"
end

if arg[3] == "-i" or arg[3] == "--instruments" then
    export_instruments = true
else
    track_name = arg[3]
    if #arg > 3 and (arg[4] == "-l" or arg[4] == "--loop") then
        loop_frame_0 = true
    end
end

-- Read the whole file
local input_file = io.open(input_file_name, "r")
if input_file == nil then
    print(string.format("!!!ERROR: Could not open input file '%s'.", input_file_name))
    os.exit(1)
end

for line in input_file:lines() do
    Lines[#Lines+1] = line:gsub("[\n\r]", "")
end
input_file:close()

if export_instruments == true then
    print(string.format("\n\14 Exporting instruments from %s to %s \14",
        input_file_name, output_file_name))
else
    print(string.format("\n\14 Exporting '%s' from %s to %s \14",
        track_name, input_file_name, output_file_name))
end

read_instruments()

print(string.format("Found %d instruments.", #Instruments + 1))
if export_instruments == true then

    for idx = 0, #Instruments do
        local i = Instruments[idx]
        print(string.format("***DEBUG: [%d]\tV=%d, A=%d, P=%d, D=%d\t%s", i.id, i.vol, i.arp, i.pit, i.dut, i.name))
    end

    -- TODO Read MACRO definitions

    -- TODO Export instruments to file

elseif track_name ~= "" then

    read_rows(track_name)

    -- Export channels to file
    local out_file = io.open(output_file_name, "w")
    if out_file == nil then
        print(string.format("!!!ERROR: Could not create output file '%s'", output_file_name))
        os.exit(1)
    end

    local asm = ""

    -- Create table of pointers to channel data in ASM (channel, pointer, channel pointer...)
    for cn = 0, 3 do
        asm = asm .. string.format("\t.byte $%02X\n\t.word channel_%02X\n",
            cn, cn)
    end
    asm = asm .. "\t.byte $FF\n"

    -- For each channel:
    for cn = 0, 3 do

        -- Add channel label
        asm = asm .. "\n; -----------------------------------------------------------------------------\n"
        asm = asm .. string.format(";\t\t\t\t\t\t%s CHANNEL", Channels[cn].name)
        asm = asm .. "\n; -----------------------------------------------------------------------------\n"
        asm = asm .. string.format("\nchannel_%02X:\n", cn)
        -- Add set speed command with track speed
        asm = asm .. string.format("\t.byte $%02X, $%02X\t; Speed = %d\n", CMD_SPEED, Speed, Speed)

        -- Process order for channel: each entry is a call to a subsection (i.e. pattern)
        -- TODO Do not use order if --loop was used
        asm = asm .. string.format("\t@order_%02X:\n", cn)
        for on = 0, #Order[cn].patterns do
            asm = asm .. string.format("\t.byte $%02X\t; CALL\n", CMD_CALL)
            asm = asm .. string.format("\t.word @pattern_%02X\n", Order[cn].patterns[on])
        end

        -- After last call, add jump back to channel label
        -- TODO Use a loop point based on JUMP effect if any
        asm = asm .. string.format("\t.byte $%02X\t; JUMP\n", CMD_JUMP)
        asm = asm .. string.format("\t.word @order_%02X\n", cn)

        -- For each pattern:
        for pn = 0, #Channels[cn].patterns do
            
            local pattern = Channels[cn].patterns[pn]
            local pattern_duration = 0

            -- Add local label
            asm = asm .. string.format("\n\t@pattern_%02X:\n", pn)

            local last_duration = -1
            local last_vol_env = -1
            local last_arp = -1
            local last_pit_env = -1
            local last_dut_env = -1

            -- For each row in pattern:
            for rn = 0, #pattern.rows do

                local row = pattern.rows[rn]

                -- 1. Dump effects
                if row.fx[1] ~= "..." then
                    for fn = 1, #row.fx do
                        local f, a = convert_fx(row.fx[fn])
                        if f > -1 then
                            -- Only apply speed effects to channel 0
                            if f == CMD_SPEED and cn ~= 0 then
                                -- Do nothing
                            else
                                asm = asm .. a
                            end
                        end
                    end
                end

                -- 2. Dump envelope change (if needed)
                if row.inst ~= "None" then
                    if row.vol_env ~= last_vol_env then
                        asm = asm .. string.format("\t.byte $%02X, $%02X\t; Volume Envelope = %s\n",
                            CMD_VOL_ENV, row.vol_env, row.inst)
                        last_vol_env = row.vol_env
                    end

                    if cn < 2 and row.dut_env ~= last_dut_env then
                        asm = asm .. string.format("\t.byte $%02X, $%02X\t; Duty Envelope = %s\n",
                            CMD_DUT_ENV, row.dut_env, row.inst)
                        last_dut_env = row.dut_env
                    end

                    if cn < 3 and row.pit_env ~= last_pit_env then
                        asm = asm .. string.format("\t.byte $%02X, $%02X\t; Pitch Envelope = %s\n",
                            CMD_PIT_ENV, row.pit_env, row.inst)
                        last_pit_env = row.pit_env
                    end

                    if row.arp ~= last_arp then
                        asm = asm .. string.format("\t.byte $%02X, $%02X\t; Arpeggio = %s\n",
                            CMD_SET_ARP, row.arp, row.inst)
                        last_arp = row.arp
                    end
                end

                if row.note ~= nil and row.note >= 0 and row.note <= 0x5F then
                    -- 3. Dump note duration (if any)
                    if row.duration ~= nil and row.duration ~= last_duration then
                        asm = asm .. string.format("\t.byte $%02X\t; Duration = %d\n",
                            0x80 + row.duration, row.duration)
                        last_duration = row.duration
                    end

                    -- 4. Dump note index, hold or rest (if any)
                    local name = Note_Names[row.note]
                    if cn == 3 then
                        name = Noise_Names[row.note]
                    end
                    asm = asm .. string.format("\t.byte $%02X\t; %s\n",
                        row.note, name)
                    pattern_duration = pattern_duration + last_duration
                end
                
            end

            -- Add "return" command at end of each pattern
            asm = asm .. string.format("\t.byte $%02X\t; RETURN", CMD_RETURN)
            -- Add pattern's total duration as a comment for debugging
            asm = asm .. string.format("\t; Pattern duration: %s.\n", pattern_duration)
        end
        
    end

    out_file:write(asm)
    out_file:close()
    print("\02 Done! \02")
end
