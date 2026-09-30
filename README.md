# John Sandberg — Portfolio

Personal portfolio site. Static HTML/CSS/JS, no build step for development.

```
index.html              home page
work/*.html             case studies
assets/styles.css       styles (colour tokens at the top)
assets/main.js          theme toggle, scroll reveals
.staticrypt/            password screen template
.staticrypt.json        shared salt (not secret) so one password unlocks every page
scripts/build.sh        builds the encrypted site into _site/
```

## Run locally

```sh
python3 -m http.server 8000   # unencrypted, then open http://localhost:8000
```

To preview the password-protected build:

```sh
STATICRYPT_PASSWORD=choose-one scripts/build.sh
cd _site && python3 -m http.server 8000
```

## Password protection

Every HTML page is encrypted with [StatiCrypt](https://github.com/robinmoisson/staticrypt)
at deploy time. Visitors see a password screen; the page is decrypted in their
browser only with the right password. "Remember me" keeps them signed in for
30 days on that device. `robots.txt` also asks search engines not to index the site.

Images and CSS are not encrypted, but nothing readable links to them.

## Deploy

Pushing to `main` builds and deploys via GitHub Actions (`.github/workflows/pages.yml`).

One-time setup:

1. **Settings → Secrets and variables → Actions → New repository secret**:
   name `SITE_PASSWORD`, value = the password you'll share.
2. **Settings → Pages → Source: GitHub Actions**.

To change the password, update the secret and re-run the workflow.
