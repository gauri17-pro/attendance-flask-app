#!/bin/sh
set -e

echo "⏳ Initialising database..."
python -c "
from app import app, db, seed_demo_teacher
with app.app_context():
    db.create_all()
    seed_demo_teacher()
    print('✅ Database ready.')
"

echo "🚀 Starting Gunicorn..."
exec gunicorn --bind 0.0.0.0:5000 --workers 2 --timeout 60 app:app