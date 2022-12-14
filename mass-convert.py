#!/usr/bin/env python3

# Mass convert all files in a directory to a different format
# Usage: mass-convert.py <input-dir> <output-dir> <output-format>
# Example: mass-convert.py /home/user/input /home/user/output jpg

import os
import sys
import subprocess
from pathlib import Path

def main():
    source_dir, target_dir, output_format = read_params()

    for source_file in source_dir.rglob('*.[fF][pP][xX]'):
        source_relative = source_file.relative_to(source_dir)

        target_file = target_dir / source_relative.parent / Path(source_file.stem + '.' + output_format)

        print(f'Converting {source_file} to {target_file}')

        target_file.parent.mkdir(parents=True, exist_ok=True)

        subprocess.run(args=['convert', str(source_file), str(target_file)], check=True)

        # Copy the file's metadata to the output file (creationt ime etc)
        subprocess.run(args=['touch', '-r', str(source_file), str(target_file)], check=True)


def read_params():
    if len(sys.argv) < 3:
        print('Usage: mass-convert.py <input-dir> <output-dir> <output-format>')
        sys.exit(1)

    source_dir = sys.argv[1]
    if source_dir is None:
        print('No source directory specified')
        sys.exit(1)

    source_dir = Path(source_dir)
    if not source_dir.exists():
        print('Source directory does not exist')
        sys.exit(1)

    target_dir = sys.argv[2]
    if target_dir is None:
        print('No target directory specified')
        sys.exit(1)

    target_dir = Path(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    output_format = sys.argv[3] if len(sys.argv) > 3 else 'jpg'

    return source_dir, target_dir, output_format


if __name__ == '__main__':
    main()
