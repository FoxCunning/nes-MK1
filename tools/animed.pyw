__author__ = "Fox Cunning"
__copyright__ = "(C)2023-2024 Fox Cunning"
__license__ = "MIT"
__version__ = "1.0"

"""
MIT License

Copyright (c) 2023-2024 Fox Cunning

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

import configparser
import os
import tkinter as tk
from tkinter import filedialog, Tk, messagebox, simpledialog
from PIL import Image, ImageTk
from typing import List
from undo_redo import UndoRedo

# ----------------------------------------------------------------------------------------------------------------------

#           Constants

# noinspection SpellCheckingInspection
FIGHTERS = [
    "Raiden", "Sonya", "Sub-Zero", "Scorpion", "Kano", "Johnny Cage", "Liu Kang", "Goro", "Shang Tsung"
]

FIGHTER_BANKS = ["05t", "06t", "07t", "08", "09", "0A", "0B", "0C", "0D"]

ANIMATIONS = ["00 Idle", "01 Crouch", "02 Crouched parry", "03 Walk forward", "04 Walk backwards", "05 Standing parry",
              "06 Jump up", "07 Jump forward", "08 Jump backwards", "09 Strong hit", "0A Hit",
              # Attack animations (0B-25)
              "0B Kick", "0C Close kick", "0D Special #1", "0E Jump-kick (up) #1", "0F Jump-kick (up) #2",
              "10 Punch", "11 Jump-punch (up) #1", "12 Jump-punch (up) #2", "13 Uppercut", "14 Crouched kick",
              "15 Jump-kick (fwd) #1", "16 Jump-punch (up) #3", "17 Special #2", "18 Throw", "19 Jump-punch (fwd) #1",
              "1A Jump-punch (fwd) #2", "1B Jump-kick (fwd) #1", "1C Jump-kick (fwd) #2", "1D Jump-special",
              "1E Special #3", "1F Jump-punch (bck) #1", "20 Jump-punch (bck) #2", "21 Jump-kick (bck) #1",
              "22 Jump-kick (bck) #2", "23 Mid-air fall back #1?", "24 Mid-air fall back #2?", "25 Close punch",
              # End of attack animations
              "26 Bounce", "27 Get up", "28 Stagger",
              "29 Shame", "2A Victory",
              # "Hit received" animations
              "2B Crouched parry hit", "2C Standing parry hit", "2D Knock-back #1", "2E Strong hit", "2F Knock-back #2",
              "30 Knock-back #3", "31 Thrown", "32 Uppercut hit", "33 Special hit", "34 Mid-air recovery"
              ]

LOG_INFO = 0
LOG_WARNING = 1
LOG_ERROR = 2
LOG_TYPES = ["INFO", "WARNING", "ERROR"]

NES_COLOURS = [[124, 124, 124],
               [0, 0, 252],
               [0, 0, 188],
               [68, 40, 188],
               [148, 0, 132],
               [168, 0, 32],
               [168, 16, 0],
               [136, 20, 0],
               [80, 48, 0],
               [0, 120, 0],
               [0, 104, 0],
               [0, 88, 0],
               [0, 64, 88],
               [0, 0, 0],
               [0, 0, 0],
               [0, 0, 0],
               [188, 188, 188],
               [0, 120, 248],
               [0, 88, 248],
               [104, 68, 252],
               [216, 0, 204],
               [228, 0, 88],
               [248, 56, 0],
               [228, 92, 16],
               [172, 124, 0],
               [0, 184, 0],
               [0, 168, 0],
               [0, 168, 68],
               [0, 136, 136],
               [0, 0, 0],
               [0, 0, 0],
               [0, 0, 0],
               [248, 248, 248],
               [60, 188, 252],
               [104, 136, 252],
               [152, 120, 248],
               [248, 120, 248],
               [248, 88, 152],
               [248, 120, 88],
               [252, 160, 68],
               [248, 184, 0],
               [184, 248, 24],
               [88, 216, 84],
               [88, 248, 152],
               [0, 232, 216],
               [120, 120, 120],
               [0, 0, 0],
               [0, 0, 0],
               [252, 252, 252],
               [164, 228, 252],
               [184, 184, 248],
               [216, 184, 248],
               [248, 184, 248],
               [248, 164, 192],
               [240, 208, 176],
               [252, 224, 168],
               [248, 216, 120],
               [216, 248, 120],
               [184, 248, 184],
               [184, 248, 216],
               [0, 252, 252],
               [248, 216, 248],
               [0, 0, 0],
               [0, 0, 0]]

TILE_BIT_MASKS = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
"""Used to retrieve the bit that tells if a sprite uses palette 0 or 1 from attribute_bits."""

SCALING = 2
"""Pixel magnification factor."""

TILE_SIZE = 16
"""Tile side length, in pixels, after magnification."""

# ----------------------------------------------------------------------------------------------------------------------

#           Globals

config: configparser
undo_redo = UndoRedo()

# Widgets
root = Tk()

log_win = tk.Toplevel(root)
log_text: tk.Text

tiles_win = tk.Toplevel(root)
tiles_canvas: tk.Canvas

edit_menu: tk.Menu
frame_left: tk.Frame
main_canvas: tk.Canvas
palette_canvas: tk.Canvas
frame_middle: tk.Frame
option_fighters: tk.OptionMenu
option_animations: tk.OptionMenu

text_frame_count: tk.Text
text_cur_frame: tk.Text
text_frame_id: tk.Text

text_width: tk.Text
text_height: tk.Text
text_offset: tk.Text
text_bank: tk.Text
text_attribute: tk.Text
text_total: tk.Text
"""Sprite count (must be <= 32)"""

label_cur_tile: tk.Label
"""Indicates currently selected sprite pattern (0x00-0x7F)"""
item_tile_selection = -1
"""Canvas item for the rectangle indicating the selected pattern."""

# Tk variables
var_fighters = tk.StringVar(root)
var_animations = tk.StringVar(root)
var_attribute = tk.IntVar(root)
"""0 (left palette) or 1 (right palette)"""

# Other variables and data
master_dir = ""
"""Base directory with source files."""
unsaved_changes = False
log = [f"MK1 Animation Editor v{__version__} by {__author__}"]
char_rom_buffer = bytearray()
tiles: list = []
tile_items: list = []
tile_grid_items: list = []
main_axis_items: list = []
main_grid_items: list = []
sprite_items: list = []
cur_chr_bank = -1
"""Currently selected CHR ROM bank."""
attribute_bits: list = []
"""One bytearray per CHR ROM bank, each containing 8 bytes (one bit per tile)"""
cur_tile_idx = 0
"""Currently selected tile from the active banks (0-127)"""
cur_frame_id = 0
"""Currently selected/displayed frame."""


# ----------------------------------------------------------------------------------------------------------------------

def parse_bytes(asm) -> bytearray:
    values = bytearray()

    for line in asm:
        if line == "":
            continue

        if line[-1] == ':':
            # Stop when a new label is found
            break

        p = line.find(".byte")
        if p != -1:
            b = line[p + 6:].split()
            for v in b:
                if v[0] == ';':
                    # Stop processing this line if the rest is a comment
                    break
                # Convert data (must be in hex format)
                values.append(int(v.strip("$,"), 16))

    return values


def parse_pointers(asm):
    labels = []

    for line in asm:
        if line == "":
            continue

        if line[-1] == ':':
            # Stop when a new label is found
            break

        p = line.find(".word")
        if p != -1:
            w = line[p + 6:].split()
            for lab in w:
                if lab[0] == ';':
                    # Stop processing this line if the rest is a comment
                    break
                labels.append(lab.strip(" ,\t"))

    return labels


class Frame:
    def __init__(self):
        self.width = 0
        self.height = 0
        self.offset = 0
        self.bank = 0
        self.attribute = 0
        self.sprites: list[int] = []


class Animation:
    def __init__(self, mov=0):
        self.movement_id = mov
        self.frame_ids: list[int] = []


class AnimationData:

    def __init__(self):
        self.animations: list[Animation] = []
        self.frames: list[Frame] = []

    @staticmethod
    def from_asm(asm):
        data = AnimationData()
        line_no = 0
        label_animations = ""
        label_frames = ""

        pointers: list[str] = []

        # Read animation data label
        for line in asm:
            p = line.find(".word")
            if p != -1:
                labels = line[p + 6:].split(',')
                label_animations = labels[0].strip()
                label_frames = labels[1].strip()
                break

        if label_animations == "" or label_frames == "":
            error("Could not find animation/frame labels. Aborting.")
            return None

        # ---- Animation data ----

        # Find animation data using its label
        for line in asm:
            line_no = line_no + 1  # We will start reading from the line after the label
            p = line.find(label_animations + ":")
            if p != -1:
                break

        if line_no == 0:
            error("Could not find animation table. Aborting.")
            return None

        # Read animation data
        # Alternate hunting for movement data index and frame list pointer
        index_found = False
        for line in asm[line_no:]:
            if line != "" and line[-1] == ':':
                # Stop when a new label is found
                break

            if index_found is False:
                # Search for movement data index (byte)
                p = line.find(".byte")
                if p != -1:
                    try:
                        v = int(line[p + 7:p + 9], 16)
                        data.animations.append(Animation(v))
                        index_found = True
                    except ValueError as err:
                        error(f"Unable to read value from line:\n{line}\nError: {err}")
                        return None
            else:
                # Search for frame table pointer (word)
                p = line.find(".word")
                if p != -1:
                    pointers.append(line[p + 6:].split()[0])
                    index_found = False

        # Now we have a label for each animation's frame list, so find the data using that label and read the values
        for a in range(0, len(data.animations)):
            # Start the search from the beginning every time, since data does not have to be in the same order
            line_no = 0
            for line in asm:
                line_no = line_no + 1
                if line.find(pointers[a] + ":") != -1:
                    data.animations[a].frame_ids = parse_bytes(asm[line_no:])

        # ---- Frame data ----

        # Find frame pointers table
        line_no = 0
        for line in asm:
            line_no = line_no + 1  # We will start reading from the line after the label
            p = line.find(label_frames + ":")
            if p != -1:
                break

        if line_no == 0:
            error("Could not find frame pointer table. Aborting.")
            return None

        # Read frame pointers
        pointers = parse_pointers(asm[line_no:])

        # Read data for each pointer
        for p in pointers:
            line_no = 0
            for line in asm:
                line_no = line_no + 1
                if line.find(p + ":") != -1:
                    values = parse_bytes(asm[line_no:])
                    if len(values) < 6:
                        error(f"Invalid frame data for '{p}'. Aborting.")
                        return None
                    frame = Frame()
                    frame.width = values[0]
                    frame.height = values[1]
                    frame.offset = values[2]
                    frame.bank = values[3]
                    frame.attribute = values[4]
                    frame.sprites = values[5:]
                    data.frames.append(frame)
                    break

        return data


# One of these for each fighter
animation_data: List[AnimationData] = []


class Palette:
    def __init__(self, indices: bytearray):
        """
        :param indices: A list of colour indices from the NES palette (0x00 to 0x3F)
        """
        self.indices = indices

        # RGB format
        self.colours = []
        for c in indices:
            self.colours = self.colours + NES_COLOURS[c]

    def replace(self, pos: int, index: int) -> None:
        self.indices[pos] = index
        self.colours[pos] = NES_COLOURS[index]

    def rgb_str(self, index) -> str:
        clr = NES_COLOURS[self.indices[index]]
        return f"#{clr[0]:02X}{clr[1]:02X}{clr[2]:02X}"


# One for each fighter
palettes: List[Palette] = []


class Tile:
    def __init__(self, image: Image):
        self.image = image
        self.photo = ImageTk.PhotoImage(image)


def error(text, show_msg=True):
    """
    Logs an error message. Optionally also shows a message box.
    :param text: Error message.
    :param show_msg: Will show a message box if True.
    :return:
    """
    add_log(text, LOG_ERROR)
    if show_msg:
        tk.messagebox.showerror("Error", text)


def warning(text, show_msg=True):
    """
    Logs a warning message. Optionally also shows a message box.
    :param text: Warning message.
    :param show_msg: Will show a message box if True.
    :return:
    """
    add_log(text, LOG_WARNING)
    if show_msg:
        tk.messagebox.showwarning("Warning", text)


def info(text, show_msg=False):
    """
    Logs an informational message. Optionally also shows a message box.
    :param text: Message text.
    :param show_msg: Will show a message box if True.
    :return:
    """
    add_log(text, LOG_INFO)
    if show_msg:
        tk.messagebox.showinfo("Info", text)


def add_log(text, log_type=LOG_INFO):
    """
    Appends a string to the log window.
    :param text: String to add.
    :param log_type: LOG_INFO | LOG_WARNING | LOG_ERROR
    :return:
    """
    t = f"{LOG_TYPES[log_type]}: {text}"
    log.append(t)
    log_text.config(state=tk.NORMAL)
    log_text.insert(index=tk.END, chars=t + '\n')
    log_text.config(state=tk.DISABLED)


def current_animation() -> int:
    """
    :return: Index of the currently selected animation.
    """
    return ANIMATIONS.index(var_animations.get())


def current_fighter() -> int:
    """
    :return: Index of the currently selected fighter.
    """
    return FIGHTERS.index(var_fighters.get())


def change_dir() -> bool:
    """
    Asks to choose a directory to load data from.
    :return:
    """
    global master_dir
    master_dir = filedialog.askdirectory(mustexist=True)

    if master_dir == "" or master_dir is None:
        return False

    return True


def load_custom_chr() -> bool:
    """
    Asks for a file name, then loads it as a new CHR set.
    :return: False if aborted or in case of error, True otherwise.
    """
    if master_dir == "":
        error("You must first select a folder.", True)
        return False

    file_name = filedialog.askopenfilename(defaultextension=".bin",
                                           filetypes=[("ROM files", ".chr .bin"), ("All files", "*.*")],
                                           initialdir=master_dir,
                                           title="Open custom CHR",
                                           parent=root)
    if file_name == "" or file_name is None:
        return False

    if not read_chr_rom(file_name):
        return False

    index = current_animation()
    select_animation(index)


def change_text(widget: tk.Text, text: str, disable: bool = False) -> None:
    """
    Changes a widget's text.
    :param widget:
    :param text:
    :param disable: If True, disables the widget after changing its value
    :return:
    """
    if disable:
        widget.configure(state=tk.NORMAL)

    widget.delete("1.0", tk.END)
    widget.insert("1.0", text)

    if disable:
        widget.configure(state=tk.DISABLED)


def update_undo_menu() -> None:
    if undo_redo.undo_count() > 0:
        edit_menu.entryconfigure(0, {"state": tk.NORMAL})
    else:
        edit_menu.entryconfigure(0, {"state": tk.DISABLED})

    if undo_redo.redo_count() > 0:
        edit_menu.entryconfigure(1, {"state": tk.NORMAL})
    else:
        edit_menu.entryconfigure(1, {"state": tk.DISABLED})


def update_sprite_count() -> None:
    """Counts sprites in the currently displayed animation frame and shows the value in its widget."""
    data = animation_data[current_fighter()].frames[cur_frame_id]
    count = 0
    for s in data.sprites:
        if s != 0xFF:
            count = count + 1
    change_text(text_total, f"{count}", True)
    # If more than 32 frames, change the colour to red
    if count > 32:
        text_total.configure({"fg": "red"})
    else:
        text_total.configure({"fg": "black"})


def get_int(widget: tk.Text) -> int:
    """
    Gets the value of a text widget as an integer.
    :param widget:
    :return: The converted value of the widget's text, or -1 in case of error.
    """
    try:
        number = int(widget.get("1.0", "end-1c"))
    except ValueError as err:
        warning(f"get_int: {err}", False)
        return -1

    return number


def read_chr_rom(file_name: str = "") -> bool:
    """
    Loads a CHR binary file.
    :param file_name: Full path of CHR binary file.
    :return: False if an error occurred, otherwise True.
    """
    global char_rom_buffer
    if file_name == "":
        file_name = master_dir + "/bin/CHR.bin"

    try:
        with open(file_name, "rb") as f:
            char_rom_buffer = bytearray(f.read())
    except IOError as err:
        error(f"Could not open file:\n{file_name}\nError: {err}")
        return False

    return True


def read_all() -> bool:
    """
    Parses all data, reads palettes and loads CHR tileset, then shows palette 0, fighter 0, animation 0.
    :return: False if an error occurred, otherwise True.
    """
    file_name = ""

    try:
        for b in range(0, 9):
            # Read animation data for each fighter
            info(f"Parsing {FIGHTERS[b]}'s data...")
            file_name = master_dir + f"/bank_{FIGHTER_BANKS[b]}.asm"
            with open(file_name, "r") as f:
                asm = f.read().split('\n')
                data = AnimationData.from_asm(asm)
                if data is None:
                    return False
                else:
                    animation_data.append(data)

        info("Loading palettes...")
        file_name = master_dir + "/bank_01.asm"
        with open(file_name, "r") as f:
            asm = f.read().split('\n')
            if read_palettes(asm) is False:
                return False

    except IOError as err:
        error(f"Could not open file:\n{file_name}\nError: {err}")
        return False

    read_attribute_bits()
    read_chr_rom()

    # Show palette 0
    show_palette(0)

    # Show animation 0, frame 0 for fighter 0
    var_fighters.set(FIGHTERS[0])
    select_animation(0)

    return True


def read_palettes(asm) -> bool:
    global palettes

    # Find the pointers table
    line_no = 0
    for n in range(0, len(asm)):
        line = asm[n]
        if line.find("tbl_fighter_palette_ptrs:") != -1:
            line_no = n + 1
            break

    if line_no == 0:
        error("Could not find tbl_fighter_palette_ptrs in bank 1. Aborting.")
        return False

    # Read all pointers to a list of strings
    pointers = parse_pointers(asm[line_no:])

    if len(pointers) < len(FIGHTERS):
        # There must be at least one palette per fighter
        error("Invalid pointers list. Aborting.")
        return False

    # Read palette indices using the pointers above
    for p in range(0, len(FIGHTERS)):
        line_no = 0
        for line in asm:
            line_no = line_no + 1
            if line.find(pointers[p] + ':') != -1:
                c = parse_bytes(asm[line_no:])
                palettes.append(Palette(c))
                break

    return True


def read_pattern(bank: int, tile: int) -> bytearray:
    """
    Reads pixel data from a 8x8 pattern stored in CHR ROM.
    :param bank: ROM Bank number.
    :param tile: The tile index (0x00 to 0xFF).
    :return: Pattern data as a list of bytes.
    """
    plane_0 = []
    plane_1 = []
    pixels = bytearray()
    # The offset in the ROM buffer is bank * (bank size) + tile index * (tile size)
    offset = bank * 1024 + tile * 16
    # Read first plane (bit 0 of each pixel)
    for _ in range(8):
        plane_0.append(char_rom_buffer[offset])
        offset = offset + 1
    # Read second plane (bit 1 of each pixel)
    for _ in range(8):
        plane_1.append(char_rom_buffer[offset])
        offset = offset + 1
    # Combine the two planes
    for index in range(8):
        for _ in range(8):
            bit_0 = (plane_0[index] & 0x80) != 0
            bit_1 = (plane_1[index] & 0x80) != 0
            plane_0[index] = plane_0[index] << 1
            plane_1[index] = plane_1[index] << 1
            pixels.append((bit_1 << 1) | bit_0)
    return pixels


def read_attribute_bits():
    """
    Parse sprite attribute bits.
    :return:
    """
    global attribute_bits
    asm_file = master_dir + "/attr_bits.asm"

    try:
        with open(asm_file, "rt") as file:
            lines = file.readlines()
    except IOError as err:
        error(err, True)
        return

    # Empty old list before reading the new values
    attribute_bits = []

    _bank = 0
    for line in lines:
        if line.find('.byte') > -1:
            # Each line contains 8 x 8 bit values = 64 sprite attributes (one full bank)
            _values = parse_bytes([line])
            attribute_bits.append(_values)
            _bank = _bank + 1
            if _bank == 0x1C:
                # Skip unused banks (these do not contain sprites)
                for _ in range(28):
                    attribute_bits.append(bytearray([0, 0, 0, 0, 0, 0, 0, 0]))
                    _bank = _bank + 1

    info(f"Read {len(attribute_bits) * 8} sprite attribute values.", False)

# ----------------------------------------------------------------------------------------------------------------------


def get_frame_sprite_index(x: int, y: int) -> int:
    """
    Converts canvas coordinates to index in the frames list.
    :param x: Horizontal position of the cursor within the canvas.
    :param y: Vertical position of the cursor within the canvas.
    :return: Index of the sprite in the frames list, or -1 if cursor out of frame.
    """
    # Get selected fighter index
    f = current_fighter()

    # Data for the selected frame
    data = animation_data[f].frames[cur_frame_id]

    delta_x = 128 - SCALING * (8 + data.offset)
    delta_y = 240 - (data.height * TILE_SIZE)

    if x < delta_x or y < delta_y:
        return -1

    if x > delta_x + (data.width * TILE_SIZE):
        return -1

    if y > 240:
        return -1

    tile_x = (x - delta_x) >> 4
    tile_y = (y - delta_y) >> 4

    # Absolute coordinates
    # print(f"Abs:  {args[0].x}, {args[0].y}")
    # Relative coordinates
    # print(f"Rel:  {args[0].x - delta_x}, {args[0].y - delta_y}")
    # Selection:
    # print(f"Tile: {tile_x}, {tile_y}")
    # print(f"Selection: {tile_x + (tile_y * data.width)}")
    return tile_x + (tile_y * data.width)


def get_tile_palette(tile_id: int) -> int:
    if tile_id < 64:
        _byte = attribute_bits[cur_chr_bank][tile_id >> 3]
        _bit = _byte & TILE_BIT_MASKS[tile_id % 8]
    else:
        _byte = attribute_bits[cur_chr_bank + 1][(tile_id - 64) >> 3]
        _bit = _byte & TILE_BIT_MASKS[tile_id % 8]

    return 0 if _bit == 0 else 1


def show_palette(index=0):
    # Clear canvas
    palette_canvas.delete(tk.ALL)

    # Create a square for each colour in the palette
    x = 0
    for p in range(0, 8):
        palette_canvas.create_rectangle(x, 0, x + 31, 31, fill=palettes[index].rgb_str(p), outline="#E0E0E0", width=1)
        x = x + 32


def show_tileset(bank: int):
    """
    Shows the current tileset for the selected fighter's animation.
    Does nothing if CHR bank is the same that is currently displayed.
    :param bank: CHR bank number (0-255)
    :return:
    """
    global cur_chr_bank
    global item_tile_selection

    if bank == cur_chr_bank:
        return

    cur_chr_bank = bank

    # Clear canvas
    tiles_canvas.delete(tk.ALL)

    # Empty image array
    tiles.clear()

    # Use the palette of the currently selected fighter
    p = current_fighter()

    # Clear canvas items
    tile_items.clear()
    x = 0
    y = 0

    for t in range(0, 128):
        pixels = bytes(read_pattern(bank, t))
        image = Image.frombytes('P', (8, 8), pixels)
        image.info["transparency"] = 0

        # Use palette 0 or 1 depending on this sprites attribute bit
        _bit = get_tile_palette(t)
        image.putpalette(palettes[p].colours[:12] if _bit == 0 else palettes[p].colours[12:])

        tiles.append(Tile(image.resize((16, 16))))

        # TODO Magnify x4
        # tiles_canvas.itemconfigure(tile_items[t], image=tiles[t].photo)
        tile_items.append(tiles_canvas.create_image(x, y, anchor="nw", image=tiles[t].photo))
        tiles_canvas.tag_lower(tile_items[t])

        x = x + 16
        if x >= 256:
            x = 0
            y = y + 16

    # (Re-)create the grid lines
    tile_grid_items.clear()
    for x in range(1, 16):
        pos = x << 4
        tile_grid_items.append(tiles_canvas.create_line(pos, 0, pos, 127, width=1, fill="#E0E0E0"))
    for y in range(1, 8):
        pos = y << 4
        tile_grid_items.append(tiles_canvas.create_line(0, pos, 255, pos, width=1, fill="#E0E0E0"))

    # Show selection
    item_tile_selection = tiles_canvas.create_rectangle(0, 0, 16, 16, width=2, outline="#F00000")


def show_frame(index: int = 0):
    """
    Draws or re-draws the frame *index* for the current fighter.
    :param index: Index of the frame to show.
    :return:
    """
    # Get selected fighter index
    f = current_fighter()

    # Show data for the selected frame
    data = animation_data[f].frames[index]

    # Base sprite coordinates
    _x = 128 - (SCALING * (8 + data.offset))
    _y = 240 - (TILE_SIZE * data.height)

    _s = 0  # Sprite index
    _c = 0  # Actual sprite count

    for y in range(0, data.height):
        _image_y = _y + (TILE_SIZE * y)

        for x in range(0, data.width):
            _image_x = _x + (TILE_SIZE * x)
            _index = data.sprites[_s]  # Get tile index (in current bank)

            if _index != 0XFF:
                # The mask is needed because the sprite is taken from the top bank
                # The game code will set bit 7 for player 2
                # For some reason, some data has that bit set, which would break this code if not cleared
                _index = _index & 0x7F

                # TODO Flip sprite if attribute flags set

                if len(sprite_items) <= _c:
                    # If an image item does not exist for this index, then create it
                    sprite_items.append(main_canvas.create_image(_image_x, _image_y, anchor="nw",
                                                                 image=tiles[_index].photo, state=tk.NORMAL))

                else:
                    # Otherwise change the existing image
                    main_canvas.coords(sprite_items[_c], _image_x, _image_y)
                    main_canvas.itemconfigure(sprite_items[_c], image=tiles[_index].photo, state=tk.NORMAL)

                # Actual sprite: increase count
                _c = _c + 1

            # Show grid item
            # TODO Skip if option deselected
            grid_colour = "white" if data.sprites[_s] != 0xFF else "red"
            if len(main_grid_items) <= _s:
                # Create new item if needed
                main_grid_items.append(main_canvas.create_rectangle(_image_x, _image_y,
                                                                    _image_x + 15, _image_y + 15,
                                                                    outline=grid_colour, width=1,
                                                                    state=tk.NORMAL))
            else:
                # Move and show existing item if there is one already
                main_canvas.coords(main_grid_items[_s], _image_x, _image_y, _image_x + 15, _image_y + 15)
                main_canvas.itemconfigure(main_grid_items[_s], outline=grid_colour, state=tk.NORMAL)
                main_canvas.tag_raise(main_grid_items[_s])

            _s = _s + 1

    # Hide sprite items that are not used
    for _spr in range(_c, len(sprite_items)):
        try:
            main_canvas.itemconfigure(sprite_items[_spr], state=tk.HIDDEN)
        except tk.TclError:
            continue

    # Hide grid items that are not used
    # TODO Skip if grid option deselected
    for _spr in range(_s, len(main_grid_items)):
        try:
            main_canvas.itemconfigure(main_grid_items[_spr], state=tk.HIDDEN)
        except tk.TclError:
            continue


def select_tile(index: int = 0):
    """
    Selects a sprite pattern from the currently displayed banks, then updates the tile selection indicator.
    :param index: 0-127
    :return:
    """
    global cur_tile_idx

    if cur_tile_idx == index:
        # Re-selecting the same tile has no effect
        return

    cur_tile_idx = index

    # Show tile number
    label_cur_tile.config(text=f"Tile[{index:02X}]")

    # Attribute bit
    _bit = get_tile_palette(index)
    var_attribute.set(_bit)

    update_tile_selection()


def update_tile_selection():
    """
    Moves the sprite pattern selection indicator above the currently selected tile
    :return:
    """
    _x = (cur_tile_idx % 16) << 4
    _y = (cur_tile_idx >> 4) << 4
    tiles_canvas.moveto(item_tile_selection, _x, _y)


def select_sprite(index: int = 0):
    """
    Selects the tile used by a sprite.
    :param index: Index of the sprite in the current animation frame.
    :return:
    """
    # Get selected fighter index
    f = current_fighter()
    # Get currently selected animation frame
    data = animation_data[f].frames[cur_frame_id]

    # Get the tile used by the selected sprite
    # print(f"Tile ID: {data.sprites[index]}")

    if data.sprites[index] == 255:
        # No sprite here
        return

    select_tile(data.sprites[index] & 0x7F)


def select_animation(index: int = 0):
    """
    Select an animation for the current fighter.
    :param index: The animation index (0-34).
    :return:
    """
    # Get selected fighter index
    f = current_fighter()

    # Show data for the selected animation
    data = animation_data[f].animations[index]

    # Show selected frame number (each animation must have at least one frame)
    change_text(text_cur_frame, "0", True)

    # Show frame count
    change_text(text_frame_count, f"{len(data.frame_ids)}", True)

    # Select first frame of this animation
    select_frame(data.frame_ids[0])


def select_frame(index: int = 0):
    """
    Shows information about the sprites in the given frame. Also shows or refreshes the current tileset.
    :param index: Index of the frame for the current fighter.
    :return:
    """
    global cur_frame_id

    # Get selected fighter index
    f = current_fighter()

    data = animation_data[f].frames[index]

    show_tileset(data.bank)

    change_text(text_frame_id, f"{index}", True)
    cur_frame_id = index

    change_text(text_width, f"{data.width}", True)
    change_text(text_height, f"{data.height}", True)
    change_text(text_offset, f"{data.offset}", True)
    change_text(text_bank, f"{data.bank}", True)
    change_text(text_attribute, f"0x{data.attribute:02X}", True)

    update_sprite_count()

    show_frame(index)

# ----------------------------------------------------------------------------------------------------------------------


def change_chr_bank(fighter: int, frame: int, new_bank: int) -> None:
    """
    Changes the CHR Bank number for the current frame and redraws it if needed.
    :param fighter: Index of the fighter to edit.
    :param frame: Index of the frame to edit.
    :param new_bank: New bank number (0-255).
    :return:
    """
    global cur_chr_bank

    animation_data[fighter].frames[frame].bank = new_bank
    if fighter == current_fighter() and frame == cur_frame_id:
        show_tileset(new_bank)
        show_frame(cur_frame_id)
        change_text(text_bank, f"{new_bank}", True)
        cur_chr_bank = new_bank


def change_sprite_id(fighter: int, frame: int, sprite: int, new_id: int) -> None:
    """
    Changes the id of the sprite used in an animation frame.
    :param fighter: Index of the fighter to edit.
    :param frame: Index of the frame in the frames list.
    :param sprite: Index of the sprite within the frame.
    :param new_id: Tile ID of the new sprite.
    :return:
    """
    animation_data[fighter].frames[frame].sprites[sprite] = new_id

    # If editing the current fighter/frame, redraw
    if fighter == current_fighter() and frame == cur_frame_id:
        show_frame(frame)
        update_sprite_count()

# ----------------------------------------------------------------------------------------------------------------------


def on_tile_canvas_click(*args):
    """
    Left-click on the tiles canvas.
    :param args: args[0].x, args[0].y = mouse click coordinates.
    :return:
    """
    # print(f"Click at:{args[0].x}, {args[0].y}")
    # print(f"Tile: {args[0].x >> 4}, {args[0].y >> 4}")
    # print(f"Selection: {(args[0].x >> 4) + ((args[0].y >> 4) << 4)}")
    select_tile((args[0].x >> 4) + ((args[0].y >> 4) << 4))


def on_main_canvas_right_click(*args):
    """
    Callback for right-click on the main canvas, where the fighter sprites and grid are displayed.
    :param args: args[0].x, args[0].y = mouse click coordinates.
    :return:
    """
    tile_id = get_frame_sprite_index(args[0].x, args[0].y)
    if tile_id >= 0:
        select_sprite(tile_id)


def on_main_canvas_left_click(*args):
    """
    Callback for left-click on the main canvas, where the fighter sprites and grid are displayed.
    :param args: args[0].x, args[0].y = mouse click coordinates.
    :return:
    """
    sprite = get_frame_sprite_index(args[0].x, args[0].y)
    if sprite < 0:
        return

    f = current_fighter()
    old_tile_idx = animation_data[f].frames[cur_frame_id].sprites[sprite]

    if (args[0].state & 0x04) == 0:
        new_tile_idx = cur_tile_idx
    else:
        # Control pressed: erase
        new_tile_idx = 0xFF

    if old_tile_idx == new_tile_idx:
        # Nothing to change
        return

    # Change sprite
    undo_redo(change_sprite_id, (f, cur_frame_id, sprite, new_tile_idx),
              (f, cur_frame_id, sprite, old_tile_idx), change_sprite_id)
    update_undo_menu()


def on_select_fighter(*_args):
    # Get selected fighter index
    f = current_fighter()

    # Show this fighter's palette
    show_palette(f)

    # Refresh animation
    on_select_anim()


def on_select_anim(*_args):
    # Get selected animation index
    a = current_animation()
    select_animation(a)


def on_frame_prev(*_args):
    # Get selected fighter index
    f = current_fighter()

    # Get selected animation index
    a = current_animation()

    data = animation_data[f].animations[a]
    frame_count = len(data.frame_ids)

    try:
        # Get currently selected frame, minus one
        _n = int(text_cur_frame.get("1.0", "end-1c")) - 1

        if _n < 0:
            # Loop from the last frame if we were already on the first
            _n = frame_count - 1

        change_text(text_cur_frame, f"{_n}", True)
        select_frame(data.frame_ids[_n])

    except ValueError:
        return


def on_frame_next(*_args):
    # Get selected fighter index
    f = current_fighter()

    # Get selected animation index
    a = current_animation()

    data = animation_data[f].animations[a]
    frame_count = len(data.frame_ids)

    try:
        # Get currently selected frame, plus one
        _n = int(text_cur_frame.get("1.0", "end-1c")) + 1

        if _n >= frame_count:
            # Loop back from zero if we were already on the last frame
            _n = 0

        change_text(text_cur_frame, f"{_n}", True)
        select_frame(data.frame_ids[_n])

    except ValueError:
        return


def on_root_destroy():
    if "Settings" not in config.sections():
        config.add_section("Settings")
    config.set("Settings", "MainW", str(root.winfo_width()))
    config.set("Settings", "MainH", str(root.winfo_height()))
    config.set("Settings", "MainX", str(root.winfo_x()))
    config.set("Settings", "MainY", str(root.winfo_y()))
    root.destroy()


def on_chr_bank_click(*_args):
    new_bank = simpledialog.askinteger("CHR Bank", "Enter a new value (0-255 or 0x00-0xFF):",
                                       initialvalue=cur_chr_bank, minvalue=0, maxvalue=255)
    if new_bank is not None:
        f = current_fighter()
        undo_redo(change_chr_bank, (f, cur_frame_id, new_bank),
                  (f, cur_frame_id, cur_chr_bank,), change_chr_bank)
        update_undo_menu()

# ----------------------------------------------------------------------------------------------------------------------


def command_undo(*_args):
    """Undo last operation and update undo/redo menu items."""
    if undo_redo.can_undo(1):
        undo_redo.undo(1)
    update_undo_menu()


def command_redo(*_args):
    """Redo last operation and update undo/redo menu items."""
    if undo_redo.can_redo(1):
        undo_redo.redo(1)
    update_undo_menu()


def command_exit():
    # TODO Don't ask confirmation if there are no unsaved changes

    if tk.messagebox.askyesno("Exit", "Are you sure you want to quit?") is True:
        on_root_destroy()


def command_save_all():
    # TODO Export data to ASM
    tk.messagebox.showwarning("Save everything", "Not yet implemented, sorry!")


def command_save_fighter(overwrite: bool = False) -> None:
    """
    Saves the current fighter's data to assembly.
    :param overwrite: If True, will not ask for confirmation before overwriting.
    :return:
    """
    global unsaved_changes

    # Set output file name depending on current fighter
    _BANKS = ["05t", "06t", "07t", "08", "09", "0A", "0B", "0C", "0D"]
    fighter = current_fighter()
    file_name = master_dir + "/bank_" + _BANKS[fighter] + ".asm"

    # Ask to overwrite
    if overwrite is False and os.path.isfile(file_name):
        if messagebox.askyesno("Save fighter", "File already exists. Overwrite?") is False:
            return

    # Build string with assembly to be saved
    # noinspection SpellCheckingInspection
    out_text = f'.segment "BANK_{_BANKS[fighter]}"\n; $8000-$8FFF\n.setcpu "6502X"\n'
    out_text += '\n.feature org_per_seg\n.feature pc_assignment\n'
    out_text += '\n.include "globals.inc"\n'
    out_text += '\n; -----------------------------------------------------------------------------\n'
    out_text += f'\n; Animation data for {FIGHTERS[fighter]}\n'
    out_text += '\nrom_8000:\n\t.word rom_8004, rom_82C7\n'
    out_text += '\n; -----------------------------------------------------------------------------\n'
    out_text += '\nrom_8004:\n'

    _ANIM_LABELS = ["idle", "crouch", "crouch_parry", "walk_fw", "walk_bk", "standing_parry", "jump_up", "jump_fw",
                    "jump_bk", "strong_hit", "regular_hit", "base_kick", "close_kick", "special_1", "jump_kick_1",
                    "jump_kick_2", "base_punch", "jump_punch_1", "jump_punch_2", "uppercut", "crouch_kick",
                    "fw_jump_kick_1", "jump_punch_3", "special_2", "throw", "fw_jump_punch_1", "fw_jump_punch_2",
                    "fw_jump_kick_2", "fw_jump_kick_3", "fw_jump_ranged", "ranged_attack", "bk_jump_punch_1",
                    "bk_jump_punch_2", "bk_jump_kick_1", "bk_jump_kick_2", "air_fall_back_1", "air_fall_back_2",
                    "close_punch", "fall_back_bounce", "get_up", "staggered", "shame", "victory",
                    "crouch_parry_hit", "stand_parry_hit", "knock_back_1", "knock_back_2", "knock_back_3",
                    "knock_back_4", "throw_fall", "uppercut_hit", "special_hit", "jump_bk_recover"]

    # Table: movement index, pointer to frame indices table
    for a in range(len(animation_data[fighter].animations)):
        anim = animation_data[fighter].animations[a]

        if anim == 0x0B:
            out_text += "\n\t; Attack animations\n"
        elif anim == 0x26:
            out_text += "\t; End of attack animations\n\n"

        out_text += f'\t.byte ${anim.movement_id:02X}\t; ${ANIMATIONS[a]}\n'
        out_text += f'\t.word anim_{_ANIM_LABELS[a]}\n'

    out_text += '\n; -----------------------------------------------------------------------------\n'
    out_text += '\n; Indices for the frame pointers table'

    # Frame indices per animation
    highest_frame_id = 0  # Save this to avoid saving unused frames
    for a in range(len(animation_data[fighter].animations)):
        anim = animation_data[fighter].animations[a]

        out_text += f'\nanim_{_ANIM_LABELS[a]}:'
        for f in range(len(anim.frame_ids)):
            if f % 8 == 0:
                out_text += '\n\t.byte '
            else:
                out_text += ', '
            out_text += f'${anim.frame_ids[f]:02X}'
            if anim.frame_ids[f] > highest_frame_id:
                highest_frame_id = anim.frame_ids[f]

    out_text += '\n; -----------------------------------------------------------------------------\n'
    out_text += '\nrom_82C7:\n'

    # Frame data pointers
    for f in range(highest_frame_id + 1):
        out_text += f'\t.word frame_{f:02X}\n'

    out_text += '\n; -----------------------------------------------------------------------------\n'

    out_text += '''\n; Frame data format example:\n    ; .byte $05\t; Horizontal tiles count
    ; .byte $09\t; Vertical tiles count
    ; .byte $10\t; X offset (8 = neutral, higher = move forward, lower = backwards)
    ; .byte $58\t; CHR bank number
    ; .byte $00\t; Sprite attributes OR mask (e.g. force flip / priority / palette)
    ; So we have 5 columns x 9 rows composing our meta-sprite
    ; $FF = no sprite to display on that position,\n\t; Otherwise it's a sprite index ($00-$7F or $80-$FE)
    ; .byte $FF, $FF, $01, $02, $FF\t; This is the top of the head
    ; .byte $05, $06, $07, $08, $FF
    ; .byte $0F, $10, $11, $12, $FF
    ; .byte $FF, $1C, $1D, $1E, $FF
    ; .byte $FF, $2A, $2B, $2C, $FF
    ; .byte $FF, $37, $38, $39, $FF
    ; .byte $FF, $47, $48, $49, $FF
    ; .byte $FF, $57, $FF, $58, $FF
    ; .byte $FF, $65, $FF, $66, $67\t; These are the feet\n'''
    out_text += '\n; -----------------------------------------------------------------------------\n'

    for frame in range(highest_frame_id + 1):
        f = animation_data[fighter].frames[frame]
        out_text += f'\nframe_{frame:02X}:\n'
        out_text += f'\t.byte ${f.width:02X}, ${f.height:02X}, ${f.offset:02X}, ${f.bank:02X}, ${f.attribute:02X}'
        for s in range(len(f.sprites)):
            if s % f.width == 0:
                out_text += f'\n\t.byte ${f.sprites[s]:02X}'
            else:
                out_text += f', ${f.sprites[s]:02X}'

    out_text += '\n\n; -----------------------------------------------------------------------------\n'

    try:
        with open(file_name, "w") as asm_file:
            asm_file.write(out_text)
    except IOError as err:
        messagebox.showerror("Save fighter", f"Error saving '{file_name}':\n{err}")
        return

    # TODO Save palette attribute data

    messagebox.showinfo("Save fighter", f"{FIGHTERS[fighter]}'s animation data saved to '{file_name}'.")
    unsaved_changes = False

# ----------------------------------------------------------------------------------------------------------------------


def bring_to_front(*_args):
    root.attributes("-topmost", 1)
    root.attributes("-topmost", 0)
    log_win.attributes("-topmost", 1)
    log_win.attributes("-topmost", 0)
    tiles_win.attributes("-topmost", 1)
    tiles_win.attributes("-topmost", 0)


def init_root_window():
    global edit_menu
    global frame_left
    global frame_middle
    global main_canvas
    global palette_canvas
    global option_fighters
    global option_animations
    global text_width
    global text_height
    global text_frame_count
    global text_cur_frame
    global text_frame_id
    global text_offset
    global text_bank
    global text_attribute
    global text_total

    # noinspection SpellCheckingInspection
    _font = ("Fixedsys", 16)

    w = config.get("Settings", "MainW", fallback=700)
    h = config.get("Settings", "MainH", fallback=360)
    x = config.get("Settings", "MainX", fallback=50)
    y = config.get("Settings", "MainY", fallback=50)

    root.title("MK1 Animation Editor")
    root.geometry(f"{w}x{h}+{x}+{y}")

    menu_bar = tk.Menu(root)

    file_menu = tk.Menu(menu_bar, tearoff=0)
    file_menu.add_command(label="Open folder", command=change_dir)
    file_menu.add_command(label="Open custom CHR", command=load_custom_chr)
    file_menu.add_separator()
    file_menu.add_command(label="Save current fighter", command=command_save_fighter)
    file_menu.add_command(label="Save everything", command=command_save_all)
    file_menu.add_separator()
    file_menu.add_command(label="Exit", command=command_exit)

    menu_bar.add_cascade(label="File", menu=file_menu)

    edit_menu = tk.Menu(menu_bar, tearoff=0)
    edit_menu.add_command(label="Undo", state=tk.DISABLED, accelerator="Ctrl+Z", command=command_undo)
    edit_menu.add_command(label="Redo", state=tk.DISABLED, accelerator="Ctrl+Y", command=command_redo)
    root.bind_all("<Control-z>", command_undo)
    root.bind_all("<Control-y>", command_redo)

    menu_bar.add_cascade(label="Edit", menu=edit_menu)

    help_menu = tk.Menu(menu_bar, tearoff=0)
    help_menu.add_command(label="Help")
    help_menu.add_command(label="About...")

    # TODO Add a "view" menu with option to show/hide the CHR tiles and log window

    root.config(menu=menu_bar)

    # ---- Left side ----

    frame_left = tk.Frame(root, border=0)
    frame_left.grid(row=0, column=0)

    var_fighters.set(FIGHTERS[0])
    option_fighters = tk.OptionMenu(frame_left, var_fighters, *FIGHTERS)
    option_fighters.grid(row=0, column=0, sticky="EW")
    var_fighters.trace("w", on_select_fighter)

    var_animations.set(ANIMATIONS[0])
    option_animations = tk.OptionMenu(frame_left, var_animations, *ANIMATIONS)
    option_animations.grid(row=1, column=0, sticky="EW")
    var_animations.trace("w", on_select_anim)

    main_canvas = tk.Canvas(frame_left, width=256, height=256, bg="#E0E0E0", cursor="hand2")
    main_canvas.grid(row=2, column=0)
    main_canvas.bind("<Button-1>", on_main_canvas_left_click)
    main_canvas.bind("<Button-2>", on_main_canvas_right_click)
    main_canvas.bind("<Button-3>", on_main_canvas_right_click)

    main_axis_items.clear()
    main_axis_items.append(main_canvas.create_line(32, 240, 223, 240, width=1, fill="magenta"))
    main_axis_items.append(main_canvas.create_line(127, 252, 127, 32, width=1, fill="magenta"))

    main_grid_items.clear()

    palette_canvas = tk.Canvas(frame_left, width=256, height=32, bg="#808080", cursor="hand2")
    palette_canvas.grid(row=3, column=0)

    # ---- Middle frame ----

    frame_middle = tk.Frame(root, border=0)
    frame_middle.grid(row=0, column=1)

    _label = tk.Label(frame_middle, text="Animation data:", anchor="n", justify="center", font=_font, pady=24)
    _label.grid(row=0, column=0, columnspan=2)

    _label = tk.Label(frame_middle, text="Frame count: ", font=_font)
    _label.grid(row=1, column=0)
    text_frame_count = tk.Text(frame_middle, width=4, height=1, font=_font, state=tk.DISABLED)
    text_frame_count.grid(row=1, column=1)

    _label = tk.Label(frame_middle, text="Current frame: ", font=_font)
    _label.grid(row=2, column=0)
    text_cur_frame = tk.Text(frame_middle, width=4, height=1, font=_font, state=tk.DISABLED)
    text_cur_frame.grid(row=2, column=1)

    button_frame_prev = tk.Button(frame_middle, text="Prev. Frame", font=_font, command=on_frame_prev)
    button_frame_prev.grid(row=3, column=0)

    button_frame_next = tk.Button(frame_middle, text="Next  Frame", font=_font, command=on_frame_next)
    button_frame_next.grid(row=3, column=1)

    _label = tk.Label(frame_middle, text="ID: ", font=_font)
    _label.grid(row=4, column=0)
    text_frame_id = tk.Text(frame_middle, width=4, height=1, font=_font, state=tk.DISABLED)
    text_frame_id.grid(row=4, column=1)

    # Current frame data

    _label = tk.Label(frame_middle, text="Frame data:", anchor="n", justify="center", font=_font, pady=24)
    _label.grid(row=5, column=0, columnspan=2)

    _label = tk.Label(frame_middle, text="Width (tiles): ", font=_font)
    _label.grid(row=6, column=0)
    text_width = tk.Text(frame_middle, width=4, height=1, font=_font)
    text_width.grid(row=6, column=1)

    _label = tk.Label(frame_middle, text="Height (tiles): ", font=_font)
    _label.grid(row=7, column=0)
    text_height = tk.Text(frame_middle, width=4, height=1, font=_font)
    text_height.grid(row=7, column=1)

    _label = tk.Label(frame_middle, text="Offset: ", font=_font)
    _label.grid(row=8, column=0)
    text_offset = tk.Text(frame_middle, width=4, height=1, font=_font)
    text_offset.grid(row=8, column=1)

    _label = tk.Label(frame_middle, text="CHR Bank: ", font=_font)
    _label.grid(row=9, column=0)
    text_bank = tk.Text(frame_middle, width=4, height=1, font=_font, state=tk.DISABLED)
    text_bank.bind("<Button-1>", on_chr_bank_click)
    text_bank.grid(row=9, column=1)

    _label = tk.Label(frame_middle, text="Attribute: ", font=_font)
    _label.grid(row=10, column=0)
    text_attribute = tk.Text(frame_middle, width=4, height=1, font=_font)
    text_attribute.grid(row=10, column=1)

    _label = tk.Label(frame_middle, text="Sprite count: ", font=_font)
    _label.grid(row=11, column=0)
    text_total = tk.Text(frame_middle, width=4, height=1, font=_font, state=tk.DISABLED)
    text_total.grid(row=11, column=1)

    # ---- Right Frame ----

    frame_right = tk.Frame(root, border=0)
    frame_right.grid(row=0, column=2, padx=(24, 0), pady=(8, 0))

    # Move controls

    button_move_up = tk.Button(frame_right, text=" Up ", font=_font)
    button_move_up.grid(row=0, column=1)

    button_move_left = tk.Button(frame_right, text=" Left", font=_font)
    button_move_left.grid(row=1, column=0)

    _label = tk.Label(frame_right, text="MOVE ", font=_font)
    _label.grid(row=1, column=1, padx=4, pady=4)

    button_move_right = tk.Button(frame_right, text="Right", font=_font)
    button_move_right.grid(row=1, column=2)

    button_move_down = tk.Button(frame_right, text="Down", font=_font)
    button_move_down.grid(row=2, column=1)

    # Expand controls

    button_exp_up = tk.Button(frame_right, text=" Up ", font=_font)
    button_exp_up.grid(row=3, column=1, pady=(32, 0))

    button_exp_left = tk.Button(frame_right, text=" Left", font=_font)
    button_exp_left.grid(row=4, column=0)

    _label = tk.Label(frame_right, text="EXPAND", font=_font)
    _label.grid(row=4, column=1, padx=4, pady=4)

    button_exp_right = tk.Button(frame_right, text="Right", font=_font)
    button_exp_right.grid(row=4, column=2)

    button_exp_down = tk.Button(frame_right, text="Down", font=_font)
    button_exp_down.grid(row=5, column=1)

    # Shrink controls

    button_shrink_up = tk.Button(frame_right, text=" Up ", font=_font)
    button_shrink_up.grid(row=6, column=1, pady=(32, 0))

    button_shrink_left = tk.Button(frame_right, text=" Left", font=_font)
    button_shrink_left.grid(row=7, column=0)

    _label = tk.Label(frame_right, text="SHRINK", font=_font)
    _label.grid(row=7, column=1)

    button_shrink_right = tk.Button(frame_right, text="Right", font=_font)
    button_shrink_right.grid(row=7, column=2)

    button_shrink_down = tk.Button(frame_right, text="Down ", font=_font)
    button_shrink_down.grid(row=8, column=1)

    root.bind("<FocusIn>", bring_to_front)


def init_log_window():
    global log_win
    global log_text

    # TODO Get geometry from INI file

    log_win.title("Log")
    log_win.geometry("512x360+100+100")
    log_win.config(bg="black")
    log_win.resizable(False, False)

    log_text = tk.Text(log_win, bg="black", fg="green yellow", font=("TkFixedFont", 9, "bold"))
    log_text.insert(tk.END, log[0] + '\n')
    log_text.config(state=tk.DISABLED)
    log_text.pack()

    log_win.bind("<FocusIn>", bring_to_front)


def init_tiles_window():
    global tiles_win
    global tiles_canvas
    global label_cur_tile

    # TODO Get geometry (at least position) from INI file for the tile picker too

    tiles_win.title("CHR ROM")
    tiles_win.geometry("256x160+660+160")
    tiles_win.config(bg="white")
    tiles_win.resizable(False, False)

    tiles_canvas = tk.Canvas(tiles_win, bg="#A0A0F0", borderwidth=0, width=256, height=128, cursor="hand2")
    tiles_canvas.pack()

    # Tile events
    tiles_canvas.bind("<Button-1>", on_tile_canvas_click)

    # noinspection SpellCheckingInspection
    _font = ("Fixedsys", 16)

    frame_info = tk.Frame(tiles_win, border=0)
    frame_info.pack()

    label_cur_tile = tk.Label(frame_info, text="Tile[00]", font=_font, bg="white")
    label_cur_tile.pack(expand=True, fill=tk.X, side=tk.LEFT)

    _label = tk.Label(frame_info, text="Palette:", font=_font, bg="white")
    _label.pack(expand=True, fill=tk.X, side=tk.LEFT)

    _radio = tk.Radiobutton(frame_info, text="L", font=_font, bg="white", value=0, relief=tk.GROOVE, indicatoron=False,
                            state=tk.DISABLED, variable=var_attribute)
    _radio.pack(expand=True, fill=tk.X, side=tk.LEFT)
    _radio = tk.Radiobutton(frame_info, text="R", font=_font, bg="white", value=1, relief=tk.GROOVE, indicatoron=False,
                            state=tk.DISABLED, variable=var_attribute)
    _radio.pack(expand=True, fill=tk.X, side=tk.LEFT)

    tiles_win.bind("<FocusIn>", bring_to_front)


# ----------------------------------------------------------------------------------------------------------------------

#          Main

if __name__ == "__main__":
    # If a configuration file is found, parse it
    config = configparser.ConfigParser()

    # noinspection SpellCheckingInspection
    config_file = "animed.ini"

    if os.path.exists(config_file):
        with open(config_file, "r") as fd:
            config.read_file(fd)

    # Initialise all windows using saved settings where applicable
    init_root_window()
    init_log_window()
    init_tiles_window()

    master_dir = config.get("Settings", "Dir", fallback=None)
    if master_dir is None or master_dir == "":
        change_dir()
    elif not os.path.isdir(master_dir):
        change_dir()

    if master_dir != "" and master_dir is not None:
        # Try to read the required files from the chosen path
        if read_all():
            if config.sections().count("Settings") == 0:
                config.add_section("Settings")
            config.set("Settings", "Dir", master_dir)

    root.protocol("WM_DELETE_WINDOW", on_root_destroy)
    root.mainloop()

    # Save configuration
    with open(config_file, "w") as fd:
        config.write(fd)
