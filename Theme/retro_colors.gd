extends Node
## Retro ANSI-style color palette for consistent theming.


# ------------------------------------------------------------------------------
# Background Colors
# ------------------------------------------------------------------------------

const BG_PRIMARY := Color(0.1, 0.1, 0.12)      # Dark background
const BG_SECONDARY := Color(0.15, 0.15, 0.18)  # Card background
const BG_TERTIARY := Color(0.2, 0.2, 0.24)     # Elevated elements


# ------------------------------------------------------------------------------
# Text Colors
# ------------------------------------------------------------------------------

const TEXT_PRIMARY := Color(0.9, 0.9, 0.85)    # Main text (warm white)
const TEXT_SECONDARY := Color(0.6, 0.6, 0.55)  # Dimmed text
const TEXT_DISABLED := Color(0.4, 0.4, 0.38)   # Disabled state


# ------------------------------------------------------------------------------
# Accent Colors (ANSI-inspired)
# ------------------------------------------------------------------------------

const ACCENT_GREEN := Color(0.2, 0.8, 0.3)     # Success, correct
const ACCENT_RED := Color(0.9, 0.3, 0.3)       # Error, incorrect
const ACCENT_YELLOW := Color(0.9, 0.8, 0.2)    # Warning, highlight
const ACCENT_CYAN := Color(0.3, 0.8, 0.9)      # Info, links
const ACCENT_MAGENTA := Color(0.8, 0.3, 0.8)   # Special


# ------------------------------------------------------------------------------
# UI Element Colors
# ------------------------------------------------------------------------------

const BUTTON_NORMAL := Color(0.25, 0.25, 0.3)
const BUTTON_HOVER := Color(0.35, 0.35, 0.4)
const BUTTON_PRESSED := Color(0.2, 0.2, 0.25)
const BUTTON_DISABLED := Color(0.18, 0.18, 0.2)

const PANEL_BG := Color(0.12, 0.12, 0.15)
const PANEL_BORDER := Color(0.3, 0.3, 0.35)

const PROGRESS_BG := Color(0.2, 0.2, 0.25)
const PROGRESS_FILL := ACCENT_GREEN


# ------------------------------------------------------------------------------
# Opacity Values
# ------------------------------------------------------------------------------

const OPACITY_FULL := 1.0
const OPACITY_DIMMED := 0.3
const OPACITY_HOVER := 0.8
