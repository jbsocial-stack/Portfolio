# John Sandberg — Portfolio

Personal portfolio site. Static HTML/CSS/JS, no build step.

```
index.html          page content
assets/styles.css   styles (colour tokens at the top)
assets/main.js      theme toggle, scroll reveals
assets/favicon.svg
```

## Run locally

```sh
python3 -m http.server 8000   # then open http://localhost:8000
```

## Deploy

Pushing to `main` deploys via GitHub Actions (`.github/workflows/pages.yml`).
One-time setup: repo **Settings → Pages → Source: GitHub Actions**.
