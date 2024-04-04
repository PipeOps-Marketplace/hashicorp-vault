FROM vault:1.13.3

# Define build arguments
ARG STORAGE_PATH
ARG DEFAULT_LEASE_TTL
ARG MAX_LEASE_TTL
ARG UI_ENABLED
ARG ENV=dev

# Set environment variables
ENV STORAGE_PATH=$STORAGE_PATH
ENV DEFAULT_LEASE_TTL=$DEFAULT_LEASE_TTL
ENV MAX_LEASE_TTL=$MAX_LEASE_TTL
ENV UI_ENABLED=$UI_ENABLED
ENV ENV=$ENV

# Create the necessary directory structure
RUN mkdir -p $STORAGE_PATH/vault/file/data

# Copy the Vault configuration file
COPY config.hcl /config.hcl

# Start Vault server with the provided configuration
CMD ["vault", "server", "-config=/config.hcl"]
