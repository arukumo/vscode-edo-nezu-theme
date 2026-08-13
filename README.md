# Edo Nezu Theme [WIP]

Calm and colorful Visual Studio Code themes for long hours of development.

## Status

This project is a work in progress. The colors, syntax highlighting, and
Workbench appearance may change while the theme is being developed.

## Concept

Edo Nezu Theme is inspired by the restrained color culture associated with
the Edo period in Japan.

The expression "Shijuhaccha Hyakunezumi" refers to the many nuanced
variations of brown and gray appreciated in that period. This theme takes
that idea as inspiration rather than treating it as a fixed color palette.

The goal is not to remove color from code. Edo Nezu Theme preserves colorful
syntax highlighting and useful contrast while reducing unnecessary visual
decoration and overly stimulating tones.

It is intended for people who spend long hours working at a computer: less
like formal wear for a special occasion, and more like familiar workwear for
everyday development.

## Themes

This extension currently includes the following themes:

- **Edo Nezu Dark**
- **Edo Nezu Light**

The Dark and Light themes currently share the same color definitions while
the palette is being developed.

## Installation

The extension is under development and is not yet available as a finished
Marketplace release.

For local development:

1. Open this repository in Visual Studio Code.
2. Press `F5` to launch an Extension Development Host window.
3. Open the Color Theme picker with `Ctrl+K Ctrl+T`.
4. Select **Edo Nezu Dark** or **Edo Nezu Light**.

## Development

Theme definitions are stored in [`themes/`](themes/). The color palette can
be exported to CSV for review and editing in Excel.

```bash
./scripts/json2csv.sh dark
```

After editing the CSV, generate a review JSON without overwriting the theme
definition:

```bash
./scripts/csv2json.sh dark
```

Compare the generated JSON with the theme definition, then apply the desired
changes to `themes/` manually after reviewing the diff. See
[`scripts/README.md`](scripts/README.md) for details.

## Screenshots

Screenshots will be added after the palette and Workbench appearance have
been finalized.

## License

This project is licensed under the [MIT License](LICENSE).  
Copyright (c) 2026 arukumo.

---

## Support

If you find this extension helpful, a coffee would be greatly appreciated! ☕

<a href="https://www.buymeacoffee.com/arukumo"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="150"></a>
