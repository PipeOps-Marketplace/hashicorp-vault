FROM hashicorp/vault:1.14

# Set environment variables
ENV STORAGE_PATH=/vault/data
ENV DEFAULT_LEASE_TTL=168h
ENV MAX_LEASE_TTL=720h
ENV UI_ENABLED=true

# Create the directory for configuration files
RUN mkdir -p /vault/config

# Copy the configuration script
COPY config.sh /config.sh

# Make the script executable and run it
RUN chmod +x /config.sh && /config.sh

# Create the Vault configuration file
RUN echo " \
{
  \"storage\": { \"file\": { \"path\": \"${STORAGE_PATH}\" } },
  \"listener\": [{ \"tcp\": { \"address\": \"[::]:8200\", \"tls_disable\": \"true\" } }],
  \"default_lease_ttl\": \"${DEFAULT_LEASE_TTL}\",
  \"max_lease_ttl\": \"${MAX_LEASE_TTL}\",
  \"ui\": ${UI_ENABLED},
  \"disable_mlock\": true
}
" > /vault/config/config.json
