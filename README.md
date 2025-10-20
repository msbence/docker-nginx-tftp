# docker-nginx-tftp

A simple Docker container that bundles TFTP-hpa and NGINX, for best results, use it with iPXE.

---

## Motivation

This setup is designed for one reason: to make iPXE booting and customization easy.

iPXE first grabs its bootloader via TFTP, then immediately looks for `autoexec.ipxe` via HTTP from the exact same IP address. Putting TFTP and Nginx in separate containers breaks this workflow, as I run these services on a MikroTik router in my homelab (to have PXE-based provisioning), where each container gets a different IP address.

---

## Usage

To get started, mount your data into the container's service directories and publish the necessary ports.

* **`/tftp`**: Files in this directory are served by `tftp-hpa`.
* **`/nginx`**: Files in this directory are served by `nginx`.

### Docker CLI

Here's how to run the container for a quick test:

```bash
docker run --rm -ti --name nginx-tftp \
  -p 80:80/tcp \
  -p 69:69/udp \
  -v ./nginx-data:/nginx \
  -v ./tftp-data:/tftp \
  ghcr.io/msbence/nginx-tftp:latest
```
