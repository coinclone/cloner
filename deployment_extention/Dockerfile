FROM derrend/viacoinclone:node

WORKDIR /root/

RUN rm /root/run.sh

COPY coin.conf /root/.viacoin/
COPY run.sh /root/

CMD ["bash", "/root/run.sh"]
