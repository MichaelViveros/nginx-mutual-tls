# NGINX Mutual TLS

https://hub.docker.com/r/mviveros/nginx-mutual-tls

This image contains an NGINX server configured with Mutual TLS which will allow your server to do client authentication in addition to server authentication.

[![Docker Pulls](https://img.shields.io/docker/pulls/mviveros/nginx-mutual-tls.svg)](https://hub.docker.com/r/mviveros/nginx-mutual-tls/)


## Setup
1. Put your certs in `./certs/`:
* `server.crt` and `server.key` - server certificate and key used for server authentication
* `ca.crt` - trusted root CA your server will allow client certificates signed by
2. Set the environment variables:
* `ALLOWED_CLIENT_S_DN` - allowed client certificate subject domain name, client certificates from other domains will result in a `403`
* `VERIFY_DEPTH` (optional) - maximum client certificate verify depth, defaults to `1` which will allow client certificates signed by one intermediate CA, set to `0` to only allow client certificates signed by the trusted root CA
3. Run it:
```
docker run -p 443:443 --env ALLOWED_CLIENT_S_DN='CN=example.com,O=Example Inc,L=Toronto,ST=Ontario,C=CA' -v `pwd`/certs/:/etc/nginx/conf.d/certs mviveros/nginx-mutual-tls
```

## Test
Assuming you have client certs in `client.crt`/`client.key` and `ca_server.crt` contains the CA your server certificate is signed by, you can test it with:
```
curl -v --cert client.crt --key client.key --cacert ca_server.crt https://localhost:443
```

## Links
* To see which specific configs were used to setup client authentication, check out commit [ee2e60e](https://github.com/MichaelViveros/nginx-mutual-tls/commit/ee2e60ec918e4ec862bc6c253e810a811f54388d)
* Docs - http://nginx.org/en/docs/http/ngx_http_ssl_module.html

## Coming Soon
* support for adding a proxy header for client subject domain name
