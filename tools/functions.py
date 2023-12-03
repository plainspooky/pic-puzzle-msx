FLOYD_STEINBERG_NEIGHBORS = (
    (+1, 0, 7),
    (-1, +1, 3),
    (-1, +1, 5),
    (+1, +1, 1),
)


def add_noise(bitmap, x, y, error):
    for offset_x, offset_y, debt in FLOYD_STEINBERG_NEIGHBORS:
        try:
            off_x, off_y = x + offset_x, y + offset_y
            bitmap[off_x, off_y] = tuple(
                (
                    color + error * debt // 16
                    for color, error in zip(bitmap[off_x, off_y], error)
                )
            )
        except IndexError:
            ...


def bsave(filename, vram):
    vram_size = len(vram) - 1

    assert isinstance(vram, bytearray) and vram_size < 65535

    header = bytearray(
        (0xFE, 0x00, 0x00, vram_size % 256, vram_size // 256, 0x00, 0x00,)
    )

    with open(filename, "wb") as f:
        f.write(header)
        f.write(vram)


def reduce_color(r, g, b, *args):
    r &= 0xE0
    g &= 0xE0
    b &= 0xC0

    return r, g, b


def split_pages(vram, width=256):
    page_0, page_1 = bytearray(), bytearray()
    vram_size = len(vram) - 1
    block = width * 2

    line = 0

    while line < vram_size:
        page_0 += vram[line : line + width]
        page_1 += vram[line + width : line + block]
        line += block

    return page_0, page_1


def to_msx2_rgb(r, g, b):
    return g | r >> 3 | b >> 6
