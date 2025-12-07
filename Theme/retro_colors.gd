extends Node
## Classic 4-color CGA palette for retro theming.


# ------------------------------------------------------------------------------
# CGA Base Colors
# ------------------------------------------------------------------------------

const CGA_BLACK := Color(0, 0, 0)
const CGA_CYAN := Color(0.333, 1.0, 1.0)       # #55FFFF
const CGA_MAGENTA := Color(1.0, 0.333, 1.0)    # #FF55FF
const CGA_WHITE := Color(1.0, 1.0, 1.0)


# ------------------------------------------------------------------------------
# Background Colors
# ------------------------------------------------------------------------------

const BG_PRIMARY := CGA_BLACK
const BG_SECONDARY := CGA_BLACK
const BG_TERTIARY := CGA_MAGENTA


# ------------------------------------------------------------------------------
# Text Colors
# ------------------------------------------------------------------------------

const TEXT_PRIMARY := CGA_WHITE
const TEXT_SECONDARY := CGA_CYAN
const TEXT_DISABLED := CGA_MAGENTA


# ------------------------------------------------------------------------------
# Accent Colors
# ------------------------------------------------------------------------------

const ACCENT_GREEN := CGA_CYAN
const ACCENT_RED := CGA_MAGENTA
const ACCENT_YELLOW := CGA_WHITE
const ACCENT_CYAN := CGA_CYAN
const ACCENT_MAGENTA := CGA_MAGENTA


# ------------------------------------------------------------------------------
# UI Element Colors
# ------------------------------------------------------------------------------

const BUTTON_NORMAL := CGA_MAGENTA
const BUTTON_HOVER := CGA_CYAN
const BUTTON_PRESSED := CGA_WHITE
const BUTTON_DISABLED := CGA_BLACK

const PANEL_BG := CGA_BLACK
const PANEL_BORDER := CGA_CYAN

const PROGRESS_BG := CGA_MAGENTA
const PROGRESS_FILL := CGA_CYAN


# ------------------------------------------------------------------------------
# Opacity Values
# ------------------------------------------------------------------------------

const OPACITY_FULL := 1.0
const OPACITY_DIMMED := 0.3
const OPACITY_HOVER := 0.8
