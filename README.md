# Camille Le Bihan — At a Glance

A quick-recap site: projects, coursework and background. Built with [Hugo](https://gohugo.io) and the [hugo-website](https://github.com/pmichaillat/hugo-website) template (PaperMod theme), containerized with Docker, and deployed to GitHub Pages.

## Run locally with Docker

Requires [Docker Desktop](https://www.docker.com/products/docker-desktop/).

**Live preview** (reloads as you edit):

```bash
docker compose up dev
```

Open http://localhost:1313.

**Production build** (static site served by nginx):

```bash
docker compose up --build web
```

Open http://localhost:8080.

Stop either one with `Ctrl + C`.

## Docker setup

The `Dockerfile` has three stages:

| Stage   | What it does |
|---------|--------------|
| `hugo`  | Installs Hugo extended (pinned to 0.147.2) on Debian. Used for live preview. |
| `build` | Copies the site and renders it to static HTML in `/site/public`. |
| `web`   | Serves the rendered site with nginx. |

## Deployment

Every push to `main` runs `.github/workflows/hugo.yml`. It builds the `build` stage of the Docker image, extracts the rendered site, and publishes it to GitHub Pages. The site URL comes from the repo name, e.g. `camillelebihan.github.io/<repo-name>/`.

One-time setup: in the repo, go to **Settings → Pages → Source** and select **GitHub Actions**.

## Structure

```
config.yml          site settings, bio, menu, social links
content/projects/   one folder per project (index.md)
content/coursework/ one folder per course project
content/about.md    experience, education, skills
static/             files served as-is (favicon, CV, photo)
```

## License

MIT. The template is © Pascal Michaillat (see `LICENSE.md`).
