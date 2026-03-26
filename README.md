# AttendTrack 📋

A sleek Flask attendance management system for teachers with PostgreSQL backend.

## Features
- 🔐 Teacher authentication (register / login)
- 🗂 Multiple attendance catalogues per teacher
- 👥 Add / remove students with roll numbers
- ✅ Mark present / absent with toggle UI
- 📅 View & edit attendance by date
- 📊 Attendance percentage reports per student
- 🐳 Docker + PostgreSQL ready

## Quick Start (Docker)

```bash
# 1. Clone and enter the directory
cd attendance-app

# 2. Build and start
docker compose up --build

# 3. Open http://localhost:5000
# Demo login: teacher / password123
```

## Local Development (without Docker)

```bash
# 1. Create a virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Set environment variables
export DB_HOST=localhost DB_USER=postgres DB_PASSWORD=postgres DB_NAME=attendance_db

# 4. Run
python app.py
```

## Environment Variables

| Variable     | Default           | Description                   |
|--------------|-------------------|-------------------------------|
| DB_USER      | postgres          | PostgreSQL username            |
| DB_PASSWORD  | postgres          | PostgreSQL password            |
| DB_HOST      | db                | PostgreSQL host                |
| DB_PORT      | 5432              | PostgreSQL port                |
| DB_NAME      | attendance_db     | Database name                  |
| SECRET_KEY   | (insecure)        | Flask session secret key       |

## Project Structure

```
attendance-app/
├── app.py                  # Flask app + routes + models
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
├── .env.example
└── templates/
    ├── base.html
    ├── login.html
    ├── register.html
    ├── dashboard.html
    ├── new_catalogue.html
    ├── catalogue.html      # Main attendance view
    └── report.html
```

## Create manifests for your application

```
kubectl create secret docker-registry docker-creds \
  --docker-username=gauris17 \
  --docker-password=YourPassword \
  --dry-run=client -o yaml > Secrets.yaml
```

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

```
  kubectl patch deployment metrics-server -n kube-system \
>   --type='merge' \
>   -p '{
>     "spec": {
>       "template": {
>         "metadata": {
>           "labels": {
>             "k8s-app": "metrics-server"
>           }
>         }
>       }
>     }
>   }'
```

```
kubectl create secret docker-registry docker-creds \
  --docker-username=gauris17 \
  --docker-password=Gauri@123 \
  --dry-run=client -o yaml | \
kubeseal \
  --controller-name sealed-secrets-controller \
  --controller-namespace kube-system \
  -o yaml | tee docker-sealedsecret.yml
```

```
kubectl create secret generic db-secrets \
  --from-literal=DB_USER=postgres --from-literal=DB_PASSWORD=postgres \
  --dry-run=client -o yaml | \
kubeseal \
  --controller-name sealed-secrets-controller \
  --controller-namespace kube-system \
  -o yaml | tee db-sealedsecret.yml
```
