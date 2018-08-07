############################################################
# Dockerfile that builds a Post Scriptum Gameserver
############################################################
FROM cm2network/steamcmd
LABEL maintainer="avilcreeggan@gmail.com"

# Run Steamcmd and install Squad
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir /home/steam/post-scriptum-dedicated \
        +app_update 844650 validate \
        +quit

ENV PORT=7787 QUERYPORT=27165 RCONPORT=21114 FIXEDMAXPLAYERS=80 RANDOM=NONE

VOLUME /home/steam/post-scriptum-dedicated

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/post-scriptum-dedicated +app_update 844650 +quit && \
        ./home/steam/post-scriptum-dedicated/PostScriptumServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM
        
# Expose ports
EXPOSE 7787 27165 21114
