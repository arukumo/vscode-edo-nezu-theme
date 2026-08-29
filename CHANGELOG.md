# Change Log

All notable changes to the "edo-nezu-theme" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.

## [0.1.1] - 2026-08-29

- Refined UI and syntax colors across themes:
  - **Edo Nezu Light**:
    - Added Modern Activity Bar styling (`modernActivityBar.*`).
    - Added `panel.background` (`#eeeaec`) to unify background colors across Problems, Output, Debug Console, and Terminal panels.
    - Adjusted `input.background` and `dropdown.background` from `#ffffff` to `#fffffc` to soften pure white glare.
    - Adjusted list hover and selection colors (`list.hoverBackground`, `list.activeSelectionBackground`, `list.inactiveSelectionBackground`).
    - Adjusted primary UI accents (`button.background`, `activityBarBadge.background`, `focusBorder`, `progressBar.background`, etc.) from `#5b7454` / `#03512e` to `#5d7d6b`.
    - Adjusted Git untracked/added status colors from `#03512e` to `#5b7454`.
    - Adjusted `statusBar.debuggingBackground` from `#d4d0c8` to `#dbced1`.
    - Adjusted `textLink.activeForeground` from `#009b78` to `#5d7d6b`.
    - Refined terminal ANSI colors and command decoration highlights.
  - **Edo Nezu Dark**:
    - Added `panel.background` (`#150e04`) to unify background colors across Problems, Output, Debug Console, and Terminal panels.
  - **Edo Nezu Dark & Light**:
    - Removed `terminal.background` in favor of `panel.background`.
    - Removed `terminalOverviewRuler.*` configurations to fallback to default behavior.
- Updated `README.md` with a new Tips & Customization section for how to adjust colors.

## [0.1.0] - 2026-08-28

- Added **Edo Nezu Light** theme, a light variant based on `Edo Nezu Dark` with adjusted color tones.
- Added `color and icon` and `dark and light` search keywords in `package.json`.

## [0.0.5] - 2026-08-27

- Enhanced Introduction and Concept sections in `README.md`.
- Updated search keywords and metadata in `package.json`.
- Refined theme colors and UI visibility:
  - Adjusted `terminal.selectionBackground` from `#39342c80` to `#5a524c80` for better visibility.
  - Adjusted `statusBar.debuggingBackground` from `#80503f` to `#947a6d` for a softer tone.
  - Adjusted Markdown heading colors from `#bbce91` to `#a4c2a9` for a calmer look.
  - Added `progressBar.background` (`#5b7454`) to unify UI accents.
  - Removed `button.hoverBackground` to use the default hover effect.

## [0.0.4] - 2026-08-25

- Added **Edo Nezu Icon Theme** and **Edo Nezu Material Icon Theme**.
- Refined syntax coloring for JSON, YAML, HTML, and XML.
- Added custom styling for Markdown blockquote borders.
- Updated README and licensing documentation.

## [0.0.3] - 2026-08-24

- Adjusted Markdown heading, bold text, and list bullet colors from red tones to green tones.

## [0.0.2] - 2026-08-23

- Unify terminology to "Edo-Nezu" across README for consistency (both "Edo-nezumi" and "Edo-nezu" are historically valid).

## [0.0.1] - 2026-08-23

- Initial release with Dark Theme.
