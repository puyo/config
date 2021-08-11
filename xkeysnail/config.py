import re
from xkeysnail import *
from xkeysnail.transform import *

define_keymap(re.compile("Firefox", re.IGNORECASE), {
    K("M-B"): K("C-LEFT"),                          # word backwards
    K("M-BACKSPACE"): K("C-BACKSPACE"),             # del word backwards
    #K("M-LEFT"): K("C-LEFT"),                       # word backwards
    #K("M-RIGHT"): K("C-RIGHT"),                     # word forwards
    K("Super-A"): K("C-A"),                         # select all
    K("Super-C"): K("C-C"),                         # copy
    K("Super-EQUAL"): K("C-EQUAL"),                 # zoom in
    K("Super-F"): K("C-F"),                         # find in page
    K("Super-KEY_0"): K("C-KEY_0"),                 # zoom reset
    K("Super-L"): K("C-L"),                         # select address bar
    K("Super-LEFT"): K("M-LEFT"),                   # back history
    K("Super-Left"): K("HOME"),                     # home
    K("Super-MINUS"): K("C-MINUS"),                 # zoom out
    K("Super-N"): K("C-N"),                         # new window
    K("Super-R"): K("C-R"),                         # reload page
    K("Super-RIGHT"): K("M-RIGHT"),                 # forward history
    K("Super-Right"): K("END"),                     # end
    K("Super-Shift-LEFT_BRACE"): K("C-PAGE_UP"),    # prev tab
    K("Super-Shift-P"): K("C-Shift-P"),             # private window
    K("Super-Shift-RIGHT_BRACE"): K("C-PAGE_DOWN"), # next tab
    K("Super-Shift-T"): K("C-Shift-T"),             # reopen closed tab
    K("Super-T"): K("C-T"),                         # new tab
    K("Super-V"): K("C-V"),                         # paste
    K("Super-W"): K("C-W"),                         # close tab
    K("Super-X"): K("C-X"),                         # cut
    K("Super-Z"): K("C-Z"),                         # undo
}, "Firefox")

define_keymap(re.compile("Gvim", re.IGNORECASE), {
    K("Super-A"): K("C-M-A"),
    K("Super-B"): K("C-M-B"),
    K("Super-C"): K("C-M-C"),
    K("Super-O"): K("C-M-O"),
    K("Super-P"): K("C-M-P"),
    K("Super-R"): K("C-M-R"),
    K("Super-S"): K("C-M-S"),
    K("Super-U"): K("C-M-U"),
    K("Super-V"): K("C-M-V"),
    K("Super-W"): K("C-M-W"),
    K("Super-X"): K("C-M-X"),
    K("Super-Z"): K("C-M-Z"),
    K("Super-SLASH"): K("C-M-Shift-C"),
}, "Gvim")
