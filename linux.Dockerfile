# escape=`
FROM lacledeslan/gamesvr-goldsource

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="LL Half-Life Deathmatch Dedicated Freeplay Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-goldsource-hldm"

COPY --chown=GoldSource:root ./amxmodx/metamod/metamod.so /app/valve/addons/metamod/dlls/metamod.so

COPY --chown=GoldSource:root ./amxmodx/amxmodx_base /app/valve/addons/amxmodx

COPY --chown=GoldSource:root ./amxmodx/amxmodx_ll-config /app/valve/addons/amxmodx

COPY --chown=GoldSource:root ./dist /app

COPY --chown=GoldSource:root ./dist/linux /app

# UPDATE USERNAME & ensure permissions
RUN usermod -l HLDM GoldSource &&`
    chmod +x /app/ll-tests/*.sh &&`
    mkdir -p /app/valve/logs &&`
    chmod 775 /app/valve/logs;

RUN echo 90 > /app/steam_appid.txt;

USER HLDM

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
