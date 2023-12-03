#!/usr/bin/env python3
from PIL import Image

from functions import add_noise, bsave, reduce_color, to_msx2_rgb

HEIGHT = 192
WIDTH = 256


def reduce(filename):
    image = Image.open(f"{filename}.png")
    bitmap = image.load()

    vram = bytearray()

    for y in range(HEIGHT):
        for x in range(WIDTH):
            old_pixel = bitmap[x, y]
            new_pixel = reduce_color(*old_pixel)

            bitmap[x, y] = new_pixel
            vram.append(to_msx2_rgb(*new_pixel))

            error = [old - new for old, new in zip(old_pixel, new_pixel)]
            add_noise(bitmap, x, y, error)

    image.save(f"{filename}_sc8.png")
    bsave(f"{filename}.sc8", vram)


for filename in (
    "bedroom",
    "boats",
    "bridge",
    "cafe",
    "field",
    "img1",
    "img2",
    "starry",
    "street",
    "vineyard",
):
    print(filename)
    reduce(filename)
