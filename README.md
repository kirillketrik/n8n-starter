# n8n + PostgreSQL + PgAdmin + Ngrok Docker Setup

This project provides a ready-to-use Docker-based setup for running the [n8n](https://n8n.io/) workflow automation tool with a PostgreSQL database and PgAdmin for database management.

## Features

- Automatic startup and configuration of n8n connected to PostgreSQL.
- PgAdmin web interface for easy PostgreSQL database administration.
- Automated ngrok tunnel setup to expose n8n with a public URL.
- Dynamic retrieval of the ngrok public URL and automatic injection into n8n environment variables (`WEBHOOK_URL` and `WEBHOOK_TUNNEL_URL`).
- Custom n8n Docker image including pre-installed `curl` and `jq` utilities for interacting with the ngrok API.
- Persistent data storage via Docker volumes for isolation and data safety.

## Requirements

- Docker
- Docker Compose
- ngrok account and an authtoken (free signup at [https://ngrok.com/](https://ngrok.com/))

## Setup and Usage

1. **Clone this repository**

   ```bash
   git clone https://github.com/kirillketrik/n8n-starter.git
   cd n8n-starter
    ```

2. **Configure your ngrok authtoken**

   Edit the `docker-compose.yml` file and replace `your_ngrok_token_here` with your actual ngrok authtoken:

   ```yaml
   environment:
     NGROK_AUTHTOKEN: your_ngrok_token_here
   ```

3. **Make sure the `start-n8n.sh` script is executable**

   ```bash
   chmod +x start-n8n.sh
   ```

4. **Start the containers**

   ```bash
   docker-compose up --build
   ```

5. **Access the services**

   * **n8n:** [http://localhost:5678](http://localhost:5678)
     Your workflow automation tool, accessible via the public ngrok URL which is dynamically injected into n8n.

   * **PgAdmin:** [http://localhost:8081](http://localhost:8081)
     PostgreSQL database administration UI
     Login with:

     * Email: `admin@admin.com`
     * Password: `admin`

   * **ngrok Web UI:** [http://localhost:4040](http://localhost:4040)
     View active tunnels and inspect traffic.

6. **Webhook URLs**

   The ngrok public URL is automatically fetched and injected into n8n environment variables:

   * `WEBHOOK_URL`
   * `WEBHOOK_TUNNEL_URL`

   This allows n8n workflows to receive webhooks via the public internet without manual URL configuration.

## File Overview

* `docker-compose.yml` — Docker Compose configuration for all services.
* `Dockerfile` — Custom n8n image adding `curl` and `jq`.
* `start-n8n.sh` — Entry script for n8n that waits for ngrok, fetches the public URL, and sets environment variables.
* Docker volumes for data persistence:

  * `db_storage_n8n` for PostgreSQL data
  * `n8n_storage` for n8n data
  * `pgadmin_data` for PgAdmin data

## Notes

* Make sure port `5678`, `8081`, and `4040` are free on your host machine.
* The ngrok tunnel URL will change every time you restart the containers unless you have a paid ngrok plan with reserved domains.
