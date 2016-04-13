FROM coinclone/bitcoin:node

WORKDIR /root/

RUN rm /root/run.sh

COPY config/coin.conf /root/.bitcoin/
COPY config/run.sh /root/

CMD ["bash", "/root/run.sh"]
