FROM vault:1.13.3

# Create the config.json file
RUN echo '{
  "storage": { "file": { "path": "'"$STORAGE_PATH"'" } },
  "listener": [{ "tcp": { "address": "[::]:8200", "tls_disable": "true" } }],
  "default_lease_ttl": "'"$DEFAULT_LEASE_TTL"'",
  "max_lease_ttl": "'"$MAX_LEASE_TTL"'",
  "ui": '$UI_ENABLED',
  "disable_mlock": true
}' > /vault/config/config.json

ARG STORAGE_PATH
ARG DEFAULT_LEASE_TTL
ARG MAX_LEASE_TTL
ARG UI_ENABLED
ARG ENV=dev

ENV STORAGE_PATH = $STORAGE_PATH
ENV DEFAULT_LEASE_TTL = $DEFAULT_LEASE_TTL
ENV MAX_LEASE_TTL = $MAX_LEASE_TTL
ENV UI_ENABLED = $UI_ENABLED
ENV ENV = $ENV

CMD if [ "$ENV" = "dev" ]; then vault server --dev; else vault server -config=/vault/config/config.json; fi
