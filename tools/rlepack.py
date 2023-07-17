"""
MIT License

Copyright (c) 2023 Fox Cunning

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import sys

in_path = ""
out_path = ""


def compress(data) -> bytearray:
    output = bytearray()

    # A buffer containing consecutive non-identical bytes
    buffer = bytearray()

    # Number of identical bytes in sequence
    count = 0

    # Read first byte
    prev_byte = data[0]
    new_byte = 0

    for p in range(1, len(data)):
        new_byte = data[p]

        if new_byte == prev_byte:
            if len(buffer) > 0:
                # Dump the contents of the buffer first, if needed
                if len(buffer) > 0x7F:
                    # Split the buffer if it's too big
                    split = len(buffer) - 0x7E
                    output.append(split | 0x80)
                    output.append(buffer[:split])
                    buffer = buffer[split:]

                output.append(len(buffer) | 0x80)
                output = output + buffer
                buffer.clear()

            # Increase sequence size counter
            if count == 0x7F:
                # Allow max 127 repeated bytes
                output.append(0x7F)
                output.append(prev_byte)
                count = 0
            count = count + 1

        else:
            # Check if a sequence of identical bytes has just ended
            if count > 0:
                if count >= 0x7F:
                    output.append(0x7F)
                    output.append(prev_byte)
                    count = count - 0x7F
                output.append(count + 1)
                output.append(prev_byte)
                count = 0
            else:
                # If not, add previous byte to the un-identical sequence
                if len(buffer) == 0x7E:
                    output.append(0xFE)
                    output = output + buffer
                    buffer.clear()
                buffer.append(prev_byte)

        prev_byte = new_byte

    # Check if we have anything left to write
    if count > 0:
        if count >= 0x7F:
            output.append(0x7F)
            output.append(prev_byte)
            count = count - 0x7F
        output.append(count + 1)
        output.append(prev_byte)
    elif len(buffer) > 0:
        buffer.append(new_byte)
        output.append(len(buffer) | 0x80)
        output = output + buffer
    else:
        output.append(0x81)
        output.append(new_byte)

    return output


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <input file> [output file]")
        sys.exit(1)

    in_path = sys.argv[1]

    if len(sys.argv) > 2:
        out_path = sys.argv[2]
    else:
        index = in_path.rfind(".")
        if index == -1:
            # If input file has no extension, just add .rle at the end
            out_path = in_path + ".rle"
        else:
            # Otherwise, replace it with .rle
            out_path = in_path[:index] + ".rle"

    print(f"Compressing {in_path} --> {out_path} ...")

    # Read input file
    try:
        with open(in_path, "rb") as in_file:
            in_buffer = in_file.read()
    except IOError as error:
        print(f"ERROR: Could not read input file '{in_file}':\n\t{error}")
        sys.exit(1)

    rle = compress(in_buffer)

    # Write output to file
    try:
        with open(out_path, "wb+") as out_file:
            out_file.write(bytearray([0x20, 0x00]))
            out_file.write(rle)
            out_file.write(b"\xFF")
    except IOError as error:
        print(f"ERROR: Could not write output file '{out_file}':\n\t{error}")
        sys.exit(1)

    print("Done!")
