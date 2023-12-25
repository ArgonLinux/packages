# sha256sum sucks.

import std/os, crunchy

let inputFile = paramStr(1)

echo toHex(sha256(readFile(inputFile)))
