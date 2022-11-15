# -*- coding: utf-8 -*-

# COPYRIGHT LICENSE: CC0 version 1.0. For reading a copy of this license, please see the file ⟪CC0 1.0 LICENSE.txt⟫.
# SPDX-License-Identifier: CC0-1.0

# ============================================================ #

import sys

def entrypoint(s :str):
  sys.stdout.write(
    " ".join(with_optimal_bracket_elision(s.split(" "))) + "\n"
  )
  return

def with_optimal_bracket_elision(
  bl :list   # ⟨𝕋⟩ Bracket List
):
  assert(isinstance(bl, list))
  assert("" not in bl)
  bl.append("")
  obl = []       # ⟨𝕋⟩ Optimal Bracket List
  cb, ci = "", 0 # 𝕋 Candidate Bracket; ℕ Candidate Index
  si = 0         # ℕ Start Index
  while True:
    dbs = set()  # {𝕋} Discarded Bracket Set
    for i, b in enumerate(bl[si:]):
      if b == "":
        if i == 0:
          return obl
        elif len(dbs) == 0:
          return obl + [cb] * i
        break
      y = cb
      if b != y and b not in dbs:
        dbs.add(y)
        cb, ci = b, i
    kbi = ci + si  # ℕ Kept Bracket Index
    obl.append(bl[kbi])
    si = kbi + 1


# ============================================================ #

# === ENTRY POINT === #

entrypoint(*sys.argv[1:])

