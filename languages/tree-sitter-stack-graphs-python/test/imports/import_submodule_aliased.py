# --- path: foo/bar.py ---

BAR = 42

# --- path: test.py ---

import foo.bar as qux

qux.BAR
# ^ defined: 7, 3
#     ^ defined: 3

foo
# ^ defined:

bar
# ^ defined:
