FROM hotio/mono@sha256:c31b63c8fbff79b79ace5f6137fae29b21a0ab83a163163ad7d5dafe9cdd9bfa

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8989

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/phantom-develop/${VERSION}/Sonarr.phantom-develop.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=phantom-develop" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

ARG ARR_DISCORD_NOTIFIER_VERSION
RUN curl -fsSL "https://raw.githubusercontent.com/hotio/arr-discord-notifier/${ARR_DISCORD_NOTIFIER_VERSION}/arr-discord-notifier.sh" > "${APP_DIR}/arr-discord-notifier.sh" && \
    chmod u=rwx,go=rx "${APP_DIR}/arr-discord-notifier.sh"

COPY root/ /
