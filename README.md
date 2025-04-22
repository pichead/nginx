
# Nginx Server Setup with Docker

This repository provides a ready-to-use Nginx configuration for serving static content and reverse-proxying applications, packaged in a Docker container with SSL support.

---

## 🚀 Prerequisites

Before you begin, ensure you have installed the following on your system:

- Docker Engine (v20.x or later)
- Docker Compose (or use `docker compose` in newer Docker CLI)
- Make (for running automation commands)

---

## 📂 Project Structure

```text
.
├── Dockerfile             # Builds Nginx image based on nginx:alpine
├── Makefile               # Defines `deploy` and `down` commands
├── docker-compose.yml     # Services, volumes, network configuration
├── nginx.conf             # Main HTTP/S configuration
├── sites-enabled/         # Virtual host definitions (example.conf)
├── ssl/                   # SSL certificates and keys
│   ├── example-cert.pem
│   └── example-key.pem
└── html/                  # Static HTML content
    ├── index.html
    └── 50x.html
```

---

## 🛠️ Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/pichead/nginx.git
   cd nginx
   ```
2. Run deployment:
   ```bash
   make deploy
   ```
   - Builds the Nginx Docker image
   - Creates or connects to the Docker network `nginx-net`
   - Starts the container named `nginx-con`

---

## ⚙️ Configuration

### 1. Static Content
- Place your static files in the `html/` directory. They will be served from `/usr/share/nginx/html`.

### 2. Virtual Hosts
- Add or modify files under `sites-enabled/`. Example configuration:

  ```nginx
  server {
      listen 80;
      listen 443 ssl http2;
      server_name yourdomain.com;

      ssl_certificate     /etc/ssl/your-cert.pem;
      ssl_certificate_key /etc/ssl/your-key.pem;

      client_max_body_size 64M;
      location / {
          proxy_pass http://your-app:3000;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
      }
  }
  ```

- After updating, reload Nginx:
  ```bash
  docker exec nginx-con nginx -s reload
  ```

### 3. SSL Certificates
1. Copy your `.pem` certificate and key to the `ssl/` folder.
2. Ensure the paths in your virtual host configs match the filenames.

---

## 🌐 Docker Network & Access

- Containers to be proxied must join the `nginx-net` network:
  ```bash
  docker network connect nginx-net your-app-container
  ```

- Access the service via:
  - HTTP: `http://<host_ip>/`
  - HTTPS: `https://<host_ip>/`

---

## 🧹 Cleanup

To stop and remove containers, network, and volumes:
```bash
make down
```  

---

## 📖 Further Reading
- [Nginx Official Docs](https://nginx.org/en/docs/)
- [Docker Nginx Images](https://hub.docker.com/_/nginx)

```

