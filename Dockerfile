FROM hashicorp/vault:1.14

ARG STORAGE_PATH
ARG DEFAULT_LEASE_TTL
ARG MAX_LEASE_TTL
ARG UI_ENABLED
ARG ENV=dev

COPY config.sh /config.sh

# Make config.sh executable and execute it
RUN chmod +x /config.sh && \
    /config.sh

# Create the config.json file
RUN echo "{
  \"storage\": { \"file\": { \"path\": \"$STORAGE_PATH\" } },
  \"listener\": [{ \"tcp\": { \"address\": \"[::]:8200\", \"tls_disable\": \"true\" } }],
  \"default_lease_ttl\": \"$DEFAULT_LEASE_TTL\",
  \"max_lease_ttl\": \"$MAX_LEASE_TTL\",
  \"ui\": $UI_ENABLED,
  \"disable_mlock\": true
}" > /vault/config/config.json

CMD if [ "$ENV" = "dev" ]; then vault server --dev; else vault server -config=/vault/config/config.json; fi
