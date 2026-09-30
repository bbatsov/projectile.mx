# projectile.mx

The source of [projectile.mx](https://projectile.mx), Projectile's landing
page. The manual lives at [docs.projectile.mx](https://docs.projectile.mx)
and is built from the [projectile](https://github.com/bbatsov/projectile)
repo instead.

The site is built with [Hugo](https://gohugo.io) and deployed to GitHub Pages
on every push to `main`, and weekly on a schedule.

## Editing

Almost everything is plain YAML or markdown:

- `content/_index.md` - the tagline, the three pillars under the hero and the
  getting-started steps (all in the front matter)
- `data/showcase.yaml` - the flagship features, one row each with a GIF
- `data/features.yaml` - the "and a lot more" links
- `data/release.yaml` - the release (or release series) the page spotlights
- `data/faq.yaml` - the FAQ
- `data/community.yaml` - help channels, related links and funding links

Screenshots and GIFs live in `static/media/`. The layout is
`layouts/home.html` and the styles are in `assets/css/main.css`.

## On a Projectile release

- **Patch and minor releases**: nothing to do. The latest version and the star
  count are fetched from the GitHub API at build time, and the weekly build
  picks up a new release. Run the Deploy workflow by hand to show it right away.
- **A release worth spotlighting**: update `data/release.yaml` with the
  series, the announcement and three or four highlights, each with a
  screenshot, and bump `fallbackVersion` in `hugo.toml`. It's only used when
  GitHub can't be reached during the build.

## Running it locally

```sh
brew install hugo   # or see https://gohugo.io/installation/
hugo server
```

Then open <http://localhost:1313>. CI builds with the Hugo version pinned in
`.github/workflows/deploy.yml` and fails on any warning, so check that
`hugo --panicOnWarning` is clean before pushing.
