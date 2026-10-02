#!/usr/bin/env python3

import argparse
import sys

from pathlib import Path
from sema.ro.creator import ROCreator


def main():
    parser = argparse.ArgumentParser(description="Build an RO-Crate from a py-sema blueprint")
    parser.add_argument("blueprint", type=Path)
    parser.add_argument("output", type=Path)

    args = parser.parse_args()
    print("Building the RO Crate")


    creator = ROCreator(
        blueprint_path=args.blueprint,
        rocrate_path=args.output,
    )
    creator.process()


if __name__ == "__main__":
    main()