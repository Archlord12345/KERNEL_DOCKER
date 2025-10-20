FROM n8nio/n8n:latest

# Set environment variables for Railway/cloud deployment
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http
ENV NODE_ENV=production
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Expose the n8n port
EXPOSE 5678

# The base image already has the correct entrypoint and healthcheck
# We just inherit everything from the official n8n image
