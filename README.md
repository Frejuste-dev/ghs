# GHS - Gestion des Heures Supplémentaires v2.0

Application complète de gestion des heures supplémentaires avec API FastAPI et interface React moderne.

## ✨ Nouvelles Fonctionnalités v2.0

### Backend
- 🔐 **Authentification JWT complète** avec gestion des rôles
- ✅ **Validateurs métier** pour les données critiques
- 🛡️ **Middlewares personnalisés** pour la gestion d'erreurs et logging
- 🧪 **Tests unitaires** avec pytest
- 📊 **Logging structuré** et monitoring
- 🌐 **Configuration CORS** avancée

### Frontend
- ⚡ **Interface React moderne** avec Vite
- 🎨 **Design system** avec Tailwind CSS
- 📱 **Interface responsive** et mobile-first
- 🔄 **Gestion d'état** avec React Query
- 🎭 **Animations fluides** et micro-interactions
- 🌙 **Thème moderne** avec glassmorphism
- 📊 **Tableaux de données** interactifs
- 🔔 **Notifications** toast élégantes

### DevOps
- 🐳 **Containerisation Docker** complète
- 🔧 **Docker Compose** pour le développement
- 🚀 **Configuration production** avec Nginx
- 📋 **Makefile** pour l'automatisation
- 🔒 **Configuration SSL** et sécurité

## 🚀 Installation et Configuration

### Prérequis
- Python 3.8+
- MySQL 8.0+
- pip ou poetry

### Installation Rapide

#### Avec Docker (Recommandé)

1. **Cloner le projet**
```bash
git clone <repository-url>
cd ghs
```

2. **Configuration**
```bash
cp .env.example .env
# Éditer .env avec vos paramètres
```

3. **Démarrer avec Docker**
```bash
# Mode développement
make dev

# Ou manuellement
docker-compose up --build
```

4. **Accéder à l'application**
- Frontend: http://localhost:80
- API: http://localhost:8000
- Documentation API: http://localhost:8000/docs

#### Installation manuelle

1. **Cloner et installer**
```bash
# Backend
cd backend
pip install -r requirements.txt

# Frontend
cd ../frontend
npm install
```

2. **Configuration**
```bash
cp .env.example .env
# Éditer .env avec vos paramètres MySQL
```

3. **Initialiser la base de données**
```bash
# Créer la base MySQL
mysql -u root -p
CREATE DATABASE ghs;
USE ghs;
SOURCE ../ghs.sql;

# Initialiser avec des données de test
python init_db.py
```

4. **Démarrer l'API**
```bash
# Backend
cd backend
python start_api.py

# Frontend (nouveau terminal)
cd frontend
npm run dev
```

## 🐳 Docker et Déploiement

### Développement
```bash
# Démarrer tous les services
make dev

# Voir les logs
make logs

# Arrêter les services
make stop
```

### Production
```bash
# Construire pour la production
make prod-build

# Démarrer en production
make prod-start

# Voir les logs de production
make prod-logs
```

### Commandes utiles
```bash
# Voir l'aide
make help

# Vérifier le statut
make status

# Nettoyer
make clean

# Sauvegarder la DB
make db-backup

# Tests
make test
```

## 📚 Structure du Projet v2.0

```
ghs/
├── backend/                 # API FastAPI
│   ├── models/             # Modèles SQLModel
│   ├── auth.py            # Authentification JWT
│   ├── middleware.py      # Middlewares personnalisés
│   ├── validators.py      # Validateurs métier
│   ├── main.py           # Application FastAPI
│   └── Dockerfile        # Image Docker backend
├── frontend/               # Interface React
│   ├── src/
│   │   ├── components/   # Composants réutilisables
│   │   ├── pages/       # Pages de l'application
│   │   ├── services/    # Services API
│   │   └── contexts/    # Contextes React
│   ├── Dockerfile       # Image Docker frontend
│   └── nginx.conf      # Configuration Nginx
├── nginx/                 # Configuration Nginx production
├── docker-compose.yml    # Orchestration développement
├── docker-compose.prod.yml # Orchestration production
├── Makefile             # Automatisation des tâches
└── README.md           # Documentation
```

### Structure Backend
```
backend/
├── models/                  # Modèles SQLModel
│   ├── __init__.py
│   ├── service.py          # Services
│   ├── employee.py         # Employés  
│   ├── account.py          # Comptes utilisateurs
│   ├── request.py          # Demandes d'heures sup
│   ├── delegation.py       # Délégations
│   └── workflow.py         # Workflows
├── auth.py                 # 🔐 Authentification JWT
├── middleware.py           # 🛡️ Middlewares personnalisés
├── validators.py           # ✅ Validateurs métier
├── database.py             # Gestion BDD
├── main.py                 # Application FastAPI
├── start_api.py            # 🚀 Script de démarrage avancé
├── init_db.py              # 🔧 Initialisation BDD
├── test_*.py               # 🧪 Tests unitaires et intégration
├── requirements.txt        # Dépendances
└── .env                    # Variables d'environnement
```

### Structure Frontend
```
frontend/
├── src/
│   ├── components/         # Composants UI
│   │   ├── ui/            # Composants de base
│   │   └── layout/        # Composants de mise en page
│   ├── pages/             # Pages de l'application
│   ├── services/          # Services API
│   ├── contexts/          # Contextes React
│   └── App.jsx           # Application principale
├── public/                # Assets statiques
├── Dockerfile            # Image Docker
├── nginx.conf           # Configuration Nginx
└── package.json         # Dépendances Node.js
```

## 🔐 Authentification

### Comptes de Test (après init_db.py)
```
admin / admin123        (Administrator)
supervisor / super123   (Supervisor)  
user / user123         (Validator)
```

## 🎨 Interface Utilisateur

### Fonctionnalités Frontend
- **Dashboard** - Vue d'ensemble avec statistiques
- **Gestion des demandes** - Création et suivi des demandes
- **Gestion des employés** - CRUD complet des employés
- **Gestion des services** - Organisation des services
- **Validation** - Interface de validation pour les superviseurs
- **Rapports** - Génération de rapports et statistiques
- **Comptes** - Gestion des comptes utilisateurs (Admin)

### Design System
- **Couleurs** - Palette cohérente avec variantes
- **Typographie** - Hiérarchie claire avec Inter font
- **Composants** - Bibliothèque de composants réutilisables
- **Animations** - Micro-interactions et transitions fluides
- **Responsive** - Adaptation mobile et desktop

### Endpoints d'Authentification
- `POST /auth/login` - Connexion avec token JWT
- `GET /auth/me` - Informations utilisateur connecté

### Utilisation
```bash
# 1. Se connecter
curl -X POST "http://localhost:8000/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin&password=admin123"

# 2. Utiliser le token
curl -X GET "http://localhost:8000/services" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

## 🔧 Configuration Avancée

### Variables d'environnement (.env)
```env
# Base de données
DB_USER=root
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=3306
DB_NAME=ghs

# Application
APP_HOST=0.0.0.0
APP_PORT=8000
DEBUG=True

# JWT
SECRET_KEY=your-super-secret-key-change-this-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# CORS
CORS_ORIGINS=http://localhost:3000,http://localhost:80

# URLs
API_URL=http://localhost:8000
FRONTEND_URL=http://localhost:80
```

## 🔗 Endpoints API v2.0

### 🔐 Authentification
- `POST /auth/login` - Connexion utilisateur
- `GET /auth/me` - Profil utilisateur

### 📋 Services (Protection par rôles)
- `GET /services` - Liste (Public)
- `GET /services/{id}` - Détail (Public)
- `POST /services` - Création (Admin/Supervisor)
- `PUT /services/{id}` - Modification (Admin/Supervisor)
- `DELETE /services/{id}` - Suppression (Admin uniquement)

### 👥 Employés (Protection par rôles)
- `GET /employees` - Liste (Public)
- `GET /employees/{id}` - Détail (Public)
- `POST /employees` - Création (Admin/Supervisor)
- `PUT /employees/{id}` - Modification (Admin/Supervisor)
- `DELETE /employees/{id}` - Suppression (Admin uniquement)

### 🔑 Comptes (Admin uniquement)
- `GET /accounts` - Liste tous les comptes
- `GET /accounts/{id}` - Détail d'un compte
- `POST /accounts` - Création de compte

### 📝 Demandes (Authentification requise)
- `GET /requests` - Liste des demandes
- `GET /requests/{id}` - Détail d'une demande
- `POST /requests` - Création (Utilisateur connecté)
- `PUT /requests/{id}` - Modification (Propriétaire ou Admin/Supervisor)

### 🔄 Délégations & Workflows (Admin/Supervisor)
- Gestion complète des délégations et workflows

## ✅ Validations Métier

### Validations Automatiques
- **Heures de travail** : Maximum 12h par demande
- **Dates** : Pas de demandes dans le passé
- **Formats** : Codes services alphanumériques, numéros employés valides
- **Cohérence** : Plages horaires et dates logiques

### Exemples d'Erreurs
```json
{
  "error": "Données invalides",
  "detail": "La durée de travail ne peut pas excéder 12 heures"
}
```

## 🧪 Tests

### Tests Unitaires
```bash
# Tests des validateurs
pytest test_validators.py -v

# Tous les tests
pytest -v
```

### Tests d'Intégration
```bash
# Tests API complets (API doit être démarrée)
python test_advanced_api.py
```

## 📖 Documentation API

- **Swagger UI** : http://localhost:8000/docs
- **ReDoc** : http://localhost:8000/redoc
- **Health Check** : http://localhost:8000/health

## 🧪 Tests

### Tests Backend
```bash
# Tous les tests
make test-backend

# Tests spécifiques
cd backend
pytest test_validators.py -v
pytest test_advanced_api.py -v
```

### Tests Frontend
```bash
# Tests unitaires
make test-frontend

# Tests E2E (à implémenter)
cd frontend
npm run test:e2e
```

## 🛡️ Sécurité

- **JWT** avec expiration configurable
- **Hachage bcrypt** des mots de passe
- **Protection par rôles** sur les endpoints sensibles
- **Validation** stricte des données d'entrée
- **Gestion d'erreurs** sécurisée (pas de fuite d'informations)

## 📊 Monitoring & Logging

- **Logging automatique** de toutes les requêtes
- **Gestion centralisée** des erreurs
- **Métriques** de performance (temps de réponse)
- **Health check** pour monitoring externe

## 🏗️ Architecture

### Middlewares
1. **ErrorHandlerMiddleware** - Gestion centralisée des erreurs
2. **LoggingMiddleware** - Logging des requêtes/réponses
3. **CORSMiddleware** - Configuration CORS

### Sécurité par Couches
1. **Authentification JWT** - Vérification des tokens
2. **Autorisation par rôles** - Contrôle d'accès granulaire
3. **Validation métier** - Règles de gestion strictes
4. **Gestion d'erreurs** - Réponses sécurisées

## 🚀 Déploiement

### Développement
```bash
make dev
```

### Production
```bash
# Construction et démarrage
make prod-build
make prod-start

# Avec SSL et domaine personnalisé
# Modifier nginx/nginx.prod.conf avec votre domaine
# Ajouter vos certificats SSL dans nginx/ssl/
```

### Monitoring et Maintenance
```bash
# Vérifier la santé des services
make health

# Voir les logs
make logs

# Sauvegarder la base de données
make db-backup

# Mettre à jour les dépendances
make update
```

## 📊 Monitoring et Logging

- **Health checks** automatiques pour tous les services
- **Logs structurés** avec rotation automatique
- **Métriques** de performance et d'utilisation
- **Alertes** en cas de problème
- **Backup automatique** de la base de données

## 🔒 Sécurité

### Mesures de sécurité implémentées
- **HTTPS** obligatoire en production
- **Headers de sécurité** (HSTS, CSP, etc.)
- **Rate limiting** sur les endpoints sensibles
- **Validation** stricte des données d'entrée
- **Authentification** JWT avec expiration
- **Autorisation** basée sur les rôles
- **Chiffrement** des mots de passe avec bcrypt

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/amazing-feature`)
3. Commit les changements (`git commit -m 'Add amazing feature'`)
4. Push vers la branche (`git push origin feature/amazing-feature`)
5. Ouvrir une Pull Request

## 📝 Changelog v2.0

### Frontend
- ✅ Interface React moderne avec Vite
- ✅ Design system complet avec Tailwind CSS
- ✅ Composants UI réutilisables
- ✅ Gestion d'état avec React Query
- ✅ Authentification et autorisation
- ✅ Interface responsive et mobile-first
- ✅ Animations et micro-interactions
- ✅ Tableaux de données interactifs
- ✅ Notifications toast élégantes

### Backend
- ✅ Authentification JWT complète
- ✅ Système de rôles et permissions
- ✅ Validateurs métier avancés
- ✅ Middlewares personnalisés
- ✅ Tests unitaires avec pytest
- ✅ Logging structuré
- ✅ Configuration CORS avancée
- ✅ Scripts d'initialisation et de test
- ✅ Documentation complète

### DevOps
- ✅ Containerisation Docker complète
- ✅ Docker Compose pour développement et production
- ✅ Configuration Nginx avec SSL
- ✅ Makefile pour l'automatisation
- ✅ Health checks et monitoring
- ✅ Backup et restauration automatisés
- ✅ Configuration de sécurité avancée

## 🆘 Support

### Problèmes courants

**Erreur de connexion à la base de données**
```bash
# Vérifier que MySQL est démarré
make status

# Réinitialiser la base de données
make db-init
```

**Problème de permissions Docker**
```bash
# Ajouter votre utilisateur au groupe docker
sudo usermod -aG docker $USER

# Redémarrer la session
```

**Port déjà utilisé**
```bash
# Voir les ports utilisés
sudo netstat -tulpn | grep :8000

# Arrêter les services
make stop
```

### Logs et debugging
```bash
# Logs détaillés
make logs

# Logs d'un service spécifique
make logs-api
make logs-frontend
make logs-mysql

# Shell dans un container
make shell-api
make shell-frontend
```
