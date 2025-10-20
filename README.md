# KERNEL_DOCKER

Conteneur Docker pour les expériences de kernel forge avec n8n.

## Description

Ce projet déploie une instance n8n (workflow automation tool) dans un conteneur Docker optimisé pour les expérimentations et l'automatisation.

## Prérequis

- Docker
- Docker Compose

## Déploiement

### Option 1: Image pré-construite depuis GitHub (Recommandé)

```bash
# Utiliser l'image hébergée sur GitHub Container Registry
docker run -d \
  --name n8n-kernel \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  ghcr.io/archlord12345/kernel_docker/n8n-kernel:latest
```

### Option 2: Docker Compose avec image hébergée

Créez un fichier `docker-compose.yml` :

```yaml
version: '3.8'
services:
  n8n:
    image: ghcr.io/archlord12345/kernel_docker/n8n-kernel:latest
    container_name: n8n-kernel
    ports:
      - "5678:5678"
    volumes:
      - n8n_data:/home/node/.n8n
    restart: unless-stopped

volumes:
  n8n_data:
```

Puis lancez :
```bash
docker-compose up -d
```

### Option 3: Build local depuis les sources

```bash
# Cloner le repository
git clone https://github.com/Archlord12345/KERNEL_DOCKER.git
cd KERNEL_DOCKER

# Utiliser docker-compose (build automatique)
docker-compose up -d

# OU build manuel
docker build -t n8n-kernel .
docker run -d --name n8n-kernel -p 5678:5678 -v n8n_data:/home/node/.n8n n8n-kernel
```

## Accès

Une fois déployé, n8n sera accessible à l'adresse :
- **URL**: http://localhost:5678
- **Port**: 5678

## Configuration

### Variables d'environnement

- `N8N_HOST`: Host d'écoute (défaut: 0.0.0.0)
- `N8N_PORT`: Port d'écoute (défaut: 5678)
- `N8N_PROTOCOL`: Protocole (défaut: http)
- `GENERIC_TIMEZONE`: Timezone (défaut: Europe/Paris)

### Volumes

- `n8n_data`: Stockage persistant des données n8n

## Commandes utiles

```bash
# Voir les logs
docker-compose logs -f n8n

# Arrêter le service
docker-compose down

# Redémarrer
docker-compose restart

# Mise à jour
docker-compose pull && docker-compose up -d
```

## Images disponibles

Les images Docker sont automatiquement construites et publiées sur GitHub Container Registry :

- **Latest** : `ghcr.io/archlord12345/kernel_docker/n8n-kernel:latest`
- **Par version** : `ghcr.io/archlord12345/kernel_docker/n8n-kernel:v1.0.0`
- **Par branche** : `ghcr.io/archlord12345/kernel_docker/n8n-kernel:main`

### Architectures supportées
- `linux/amd64` (x86_64)
- `linux/arm64` (ARM64/Apple Silicon)

## Santé du conteneur

Le conteneur inclut un health check qui vérifie la disponibilité de n8n toutes les 30 secondes.

## Publication automatique

À chaque push sur `main` ou création de tag `v*`, GitHub Actions :
1. ✅ Construit l'image Docker multi-architecture
2. ✅ Exécute les tests de santé
3. ✅ Publie l'image sur GitHub Container Registry
4. ✅ Met en cache les layers pour des builds plus rapides
