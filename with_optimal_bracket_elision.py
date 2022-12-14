# -*- coding: utf-8 -*-

# COPYRIGHT LICENSE: CC0 version 1.0. For reading a copy of this license, please see the file âªCC0 1.0 LICENSE.txtâ«.
# SPDX-License-Identifier: CC0-1.0

# ============================================================ #

import sys

def entrypoint(s :str):
  sys.stdout.write(
    " ".join(with_optimal_bracket_elision(s.split(" "))) + "\n"
  )
  return

def with_optimal_bracket_elision(
  bl :list   # â¨ðâ© Bracket List
):
  assert(isinstance(bl, list))
  assert("" not in bl)
  bl.append("")
  obl = []       # â¨ðâ© Optimal Bracket List
  cb, ci = "", 0 # ð Candidate Bracket; â Candidate Index
  si = 0         # â Start Index
  while True:
    dbs = set()  # {ð} Discarded Bracket Set
    for i, b in enumerate(bl[si:]):
      if b == "":
        if i == 0:
          return obl
        elif len(dbs) == 0:
          return obl + [cb] * i
        break
      if b != cb and b not in dbs:
        dbs.add(cb)
        cb, ci = b, i
    obl.append(cb)
    si += ci + 1

# â Alternative algorithm with the same behavior:
def with_optimal_bracket_elision_alt(
  bl :list   # â¨ðâ© Bracket List
):
  assert(isinstance(bl, list))
  assert("" not in bl)
  bl.append("")
  obl = []       # â¨ðâ© Optimal Bracket List
  cb, ci = "", 0 # ð Candidate Bracket; â? Candidate Index
  si = 0         # â Start Index
  while True:
    dbs = set()  # {ð} Discarded Bracket Set
    for i, b in enumerate(bl[si:]):
      if b == "":
        if i == 0:
          ci = None
        break
      if b != cb and b not in dbs:
        dbs.add(cb)
        cb, ci = b, i
    if ci == None:
      return obl
    obl.append(cb)
    si += ci + 1

# ============================================================ #

# === ENTRY POINT === #

entrypoint(*sys.argv[1:])

