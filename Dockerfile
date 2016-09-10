FROM fedora:24

RUN \
  dnf update -y && \
  dnf install -y \
      tar \
      gzip \
      gpg \
      jq && \
  dnf clean all

ARG ACBUILD_VERSION=0.4.0
ARG ACBUILD_SHA256=70547b27e8a94a9a73a9bbb86ace163b3866fe9f767ef2edc9d32371c4dcd787

RUN \
  curl -LO https://github.com/appc/acbuild/releases/download/v${ACBUILD_VERSION}/acbuild-v${ACBUILD_VERSION}.tar.gz && \
  echo "$ACBUILD_SHA256  acbuild-v${ACBUILD_VERSION}.tar.gz" | sha256sum -c && \
  mkdir -p /opt/bin && \
  tar -C /opt/bin --strip-components 1 -xf acbuild-v${ACBUILD_VERSION}.tar.gz && \
  rm -rf /acbuild-v${ACBUILD_VERSION}.tar.gz

ENV PATH=/opt/bin:${PATH}

COPY assets/ /opt/resource/
