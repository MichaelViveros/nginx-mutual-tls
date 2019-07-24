FROM nginx:1.17.1

EXPOSE 443

COPY default.conf /etc/nginx/conf.d/

ENV VERIFY_DEPTH 1
ENV ALLOWED_CLIENT_S_DN 'CN=dunder-mifflin.com,O=Dunder Mifflin Inc,L=Scranton,ST=Pennsylvania,C=US'
CMD envsubst '${VERIFY_DEPTH} ${ALLOWED_CLIENT_S_DN}' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'
