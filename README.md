# Landing Pages

Static landing pages with OpnForm embed support, deployed on Fly.io.

## Architecture

Simple, minimal architecture for static landing pages:

```
LandingPages/
├── public/           # Static HTML/CSS/JS files
│   └── index.html    # Main landing page
├── Dockerfile        # nginx:alpine container
├── nginx.conf        # Optimized nginx config
├── fly.toml          # Fly.io deployment config
└── README.md
```

## Key Design Decisions

Based on lessons learned from fly-opnform project:

1. **Minimal footprint**: nginx:alpine base image (~23MB)
2. **Port 8080**: Fly.io standard internal port
3. **Health checks**: `/health` endpoint for Fly.io monitoring
4. **Auto-scaling**: Machines stop when idle, start on request
5. **Gzip compression**: Enabled for text assets
6. **Security headers**: X-Frame-Options, X-Content-Type-Options, X-XSS-Protection

## Deployment

### First-time setup

```bash
cd LandingPages

# Install flyctl if needed
curl -L https://fly.io/install.sh | sh
export PATH="$HOME/.fly/bin:$PATH"

# Login to Fly.io
fly auth login

# Launch the app (creates app and deploys)
fly launch --name your-landing-page --region iad --yes
```

### Subsequent deployments

```bash
fly deploy
```

### Local testing

```bash
# Build and run locally
docker build -t landing-pages .
docker run -p 8080:8080 landing-pages

# Visit http://localhost:8080
```

## Adding OpnForm Embed

Replace the placeholder in public/index.html with your OpnForm embed code.

## Cost Optimization

- Uses shared CPU (256MB RAM) - minimal cost
- Auto-stop when idle - no charges during inactivity
- Single region deployment - reduces complexity
