import sys
import os
import re
from os import path

if __name__ == '__main__':

    DISCLAIMER = \
    re.sub(r'^\s+', '', """
    ###################################################################
    #               THIS FILE WAS AUTO-GENERATED BY DOT-DROP          #
    #                         DO NOT EDIT MANUALLY                    #
    ###################################################################
    """, flags=re.MULTILINE)

    with open(sys.argv[1], 'rb', 0) as f:
        print (DISCLAIMER)
        sys.stdout.flush()
        os.write(sys.stdout.fileno(), f.read())
