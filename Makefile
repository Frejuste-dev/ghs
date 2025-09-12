# Makefile pour le projet GHS

# Variables
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_PROD = docker-compose -f docker-compose.prod.yml
BACKEND_DIR = backend
FRONTEND_DIR = frontend

# Couleurs pour les messages
GREEN = \033[0;32m
]
YELLOW = \033[1;33m
]
RED = \033[0;31m
]
NC = \033[0m # No Color
]

.PHONY: help install dev build start stop clean logs test lint format

# Aide
help:
	@echo "$(GREEN)Commandes disponibles pour GHS:$(NC)"
	@echo "  $(YELLOW)install$(NC)     - Installer les dépendances"
	@echo "  $(YELLOW)dev$(NC)         - Démarrer en mode développement"
	@echo "  $(YELLOW)build$(NC)       - Construire les images Docker"
	@echo "  $(YELLOW)start$(NC)       - Démarrer les services"
	@echo "  $(YELLOW)stop$(NC)        - Arrêter les services"
	@echo "  $(YELLOW)restart$(NC)     - Redémarrer les services"
	@echo "  $(YELLOW)logs$(NC)        - Voir les logs"
	@echo "  $(YELLOW)clean$(NC)       - Nettoyer les containers et volumes"
	@echo "  $(YELLOW)test$(NC)        - Lancer les tests"
	@echo "  $(YELLOW)lint$(NC)        - Vérifier le code"
	@echo "  $(YELLOW)format$(NC)      - Formater le code"
	@echo "  $(YELLOW)prod-build$(NC)  - Construire pour la production"
	@echo "  $(YELLOW)prod-start$(NC)  - Démarrer en production"
	@echo "  $(YELLOW)backup$(NC)      - Sauvegarder la base de données"
	@echo "  $(YELLOW)restore$(NC)     - Restaurer la base de données"

# Installation des dépendances
install:
	@echo "$(GREEN)Installation des dépendances...$(NC)"
	cd $(BACKEND_DIR) && pip install -r requirements.txt
	cd $(FRONTEND_DIR) && npm install

# Mode développement
dev:
	@echo "$(GREEN)Démarrage en mode développement...$(NC)"
	$(DOCKER_COMPOSE) up --build

# Construction des images
build:
	@echo "$(GREEN)Construction des images Docker...$(NC)"
	$(DOCKER_COMPOSE) build

# Démarrage des services
start:
	@echo "$(GREEN)Démarrage des services...$(NC)"
	$(DOCKER_COMPOSE) up -d

# Arrêt des services
stop:
	@echo "$(YELLOW)Arrêt des services...$(NC)"
	$(DOCKER_COMPOSE) down

# Redémarrage des services
restart: stop start

# Logs
logs:
	@echo "$(GREEN)Affichage des logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f

# Logs d'un service spécifique
logs-api:
	$(DOCKER_COMPOSE) logs -f api

logs-frontend:
	$(DOCKER_COMPOSE) logs -f frontend

logs-mysql:
	$(DOCKER_COMPOSE) logs -f mysql

# Nettoyage
clean:
	@echo "$(RED)Nettoyage des containers et volumes...$(NC)"
	$(DOCKER_COMPOSE) down -v --remove-orphans
	docker system prune -f

# Tests
test:
	@echo "$(GREEN)Lancement des tests...$(NC)"
	cd $(BACKEND_DIR) && python -m pytest
	cd $(FRONTEND_DIR) && npm test

# Tests backend uniquement
test-backend:
	cd $(BACKEND_DIR) && python -m pytest -v

# Tests frontend uniquement
test-frontend:
	cd $(FRONTEND_DIR) && npm test

# Linting
lint:
	@echo "$(GREEN)Vérification du code...$(NC)"
	cd $(BACKEND_DIR) && flake8 .
	cd $(FRONTEND_DIR) && npm run lint

# Formatage du code
format:
	@echo "$(GREEN)Formatage du code...$(NC)"
	cd $(BACKEND_DIR) && black .
	cd $(FRONTEND_DIR) && npm run format

# Production
prod-build:
	@echo "$(GREEN)Construction pour la production...$(NC)"
	$(DOCKER_COMPOSE_PROD) build

prod-start:
	@echo "$(GREEN)Démarrage en production...$(NC)"
	$(DOCKER_COMPOSE_PROD) up -d

prod-stop:
	@echo "$(YELLOW)Arrêt de la production...$(NC)"
	$(DOCKER_COMPOSE_PROD) down

prod-logs:
	$(DOCKER_COMPOSE_PROD) logs -f

# Base de données
db-init:
	@echo "$(GREEN)Initialisation de la base de données...$(NC)"
	cd $(BACKEND_DIR) && python init_db.py

db-backup:
	@echo "$(GREEN)Sauvegarde de la base de données...$(NC)"
	docker exec ghs_mysql mysqldump -u root -pRoot@MySQLAdmin12 ghs > backup_$(shell date +%Y%m%d_%H%M%S).sql

db-restore:
	@echo "$(GREEN)Restauration de la base de données...$(NC)"
	@read -p "Nom du fichier de sauvegarde: \" backup_file; \
	docker exec -i ghs_mysql mysql -u root -pRoot@MySQLAdmin12 ghs < $$backup_file

# Monitoring
status:
	@echo "$(GREEN)Statut des services:$(NC)"
	$(DOCKER_COMPOSE) ps

health:
	@echo "$(GREEN)Vérification de la santé des services:$(NC)"
	curl -f http://localhost:8000/health || echo "$(RED)API non disponible$(NC)"
	curl -f http://localhost:80 || echo "$(RED)Frontend non disponible$(NC)"

# Utilitaires
shell-api:
	$(DOCKER_COMPOSE) exec api bash

shell-frontend:
	$(DOCKER_COMPOSE) exec frontend sh

shell-mysql:
	$(DOCKER_COMPOSE) exec mysql mysql -u root -pRoot@MySQLAdmin12 ghs

# Mise à jour
update:
	@echo "$(GREEN)Mise à jour des dépendances...$(NC)"
	cd $(BACKEND_DIR) && pip install --upgrade -r requirements.txt
	cd $(FRONTEND_DIR) && npm update

# Documentation
docs:
	@echo "$(GREEN)Génération de la documentation...$(NC)"
	@echo "API Documentation: http://localhost:8000/docs"
	@echo "Frontend: http://localhost:80"

# Sécurité
security-check:
	@echo "$(GREEN)Vérification de sécurité...$(NC)"
	cd $(BACKEND_DIR) && safety check
	cd $(FRONTEND_DIR) && npm audit