FROM vault:1.13.3

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

RUN mkdir -p $STORAGE_PATH

RUN mkdir -p 


COPY config.hcl ./config.hcl

CMD vault server -config=config.hcl

