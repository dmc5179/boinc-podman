FROM ubi7/ubi:latest

LABEL maintainer="danclark@redhat.com" \
      description="BOINC client." \
      boinc-version="7.16.1"

# Global environment settings
# Use --insecure since we're in a container and don't need more app sandboxing?
ENV BOINC_GUI_RPC_PASSWORD="123" \
    BOINC_REMOTE_HOST="127.0.0.1" \
    BOINC_CMD_LINE_OPTIONS="--daemon --dir /var/lib/boinc --fetch_minimal_work --gui_rpc_port 31416 --allow_remote_gui_rpc --gui_rpc_unix_domain --insecure"\
    DEBIAN_FRONTEND=noninteractive

COPY start-boinc.sh /usr/bin/

# Configure
WORKDIR /var/lib/boinc

# BOINC RPC port
EXPOSE 31416

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && yum -y install boinc-client \
 && yum clean all \
 && rm -rf /var/cache/yum

ENTRYPOINT ["/usr/bin/start-boinc.sh"]
