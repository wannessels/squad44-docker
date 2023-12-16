############################################################
# Dockerfile that builds a Squad44 Gameserver
############################################################
FROM cm2network/steamcmd

# Run Steamcmd and install Squad44
RUN ./home/steam/steamcmd/steamcmd.sh +login anonymous \
        +force_install_dir /home/steam/squad44-dedicated \
        +app_update 746200 validate \
        +quit

ENV PORT=7787 QUERYPORT=27165 RCONPORT=21114 FIXEDMAXPLAYERS=80 RANDOM=NONE

VOLUME /home/steam/squad44-dedicated

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/squad44-dedicated +app_update 746200 +quit && \
        ./home/steam/squad44-dedicated/PostScriptumServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM
        
# Expose ports
EXPOSE 7787 27165 21114
