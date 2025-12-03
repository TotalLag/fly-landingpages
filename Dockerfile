# Simple nginx static site for Fly.io
# Lessons learned: Keep it minimal, use alpine for small image size

FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static files
COPY public/ /usr/share/nginx/html/

# Expose port 8080 (Fly.io standard)
EXPOSE 8080

# Health check for Fly.io
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]