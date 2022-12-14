# imagemagick-fpx
A docker image with [ImageMagick](github.com/ImageMagick/ImageMagick), [libfpx](https://github.com/ImageMagick/libfpx) and FPX support that may save your old family pictures.

## Why?
[Kodak FlashPix (FPX)](https://en.wikipedia.org/wiki/FlashPix) is an image format from ~1995. It is hard to find software that can open these images these days. Some tools that "support" FPX are:
- [XnView](https://www.xnview.com) or XnViewMP
- [IrfanView](https://www.irfanview.com/main_what_is_ger.htm) (32 Bits and with Plugins _only_)
- Some version of [ACDSee](https://help.acdsystems.com/de/acdsee-pro-2-mac/Content/1Topics/8_File_formats/Supported_file_formats.htm)
- And ancient Photo editors like CorelDRAW

I tried almost all of these and each of them had different problems. For example, XnView was crashing very often. IrfanView rendered a black image.

So I took the time and compiled libfpx and ImageMagick with fpx support. This repository/container exists so you don't have to.

## Usage
The entrypoint of the image is `magick`, so you can just use ordinary ImageMagick commands to convert your file:
```sh
# pull image once
docker pull ghcr.io/nikeee/imagemagick-fpx

# use magick
docker run --rm -it -v $(pwd):/images ghcr.io/nikeee/imagemagick-fpx -version
# Output:
# Version: ImageMagick 7.1.0-55 beta Q16-HDRI x86_64 f5cf5baad:20221210 https://imagemagick.org
# Copyright: (C) 1999 ImageMagick Studio LLC
# License: https://imagemagick.org/script/license.php
# Features: Cipher DPC HDRI Modules OpenMP(4.5)
# Delegates (built-in): fpx jbig jpeg ltdl
# Compiler: gcc (10.2)

# convert a file
docker run --rm -it -v $(pwd):/images ghcr.io/nikeee/imagemagick-fpx /images/<source-image>.fpx /images/<target-image>.jpg

# Example:
# Converts file "P0001224.FPX" to "P0001224.FPX.jpg" in the current directory
docker run --rm -it -v $(pwd):/images ghcr.io/nikeee/imagemagick-fpx /images/P0001224.FPX /images/P0001224.FPX.jpg
```

The container also contains a script that converts all files in a directory, recursively and while keeping the directory structure:
```sh
docker run --rm -it -v $(pwd):/images --entrypoint mass-convert ghcr.io/nikeee/imagemagick-fpx /images /images/out
```

If you need a test file, you can convert [an old picture of my cat](./assets/CAT.FPX).

## License
[MIT](./LICENSE)

If this helped recovering old photos, [you can buy me a coffee](https://github.com/sponsors/nikeee). Or just make someone happy with the photos.
