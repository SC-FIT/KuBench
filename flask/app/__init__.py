import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from prometheus_flask_exporter import PrometheusMetrics


db = SQLAlchemy()

class Config:
    SQLALCHEMY_DATABASE_URI = f"postgresql://{os.getenv('DB_USERNAME', 'admin')}:{os.getenv('DB_PASSWORD', 'admin')}@{os.getenv('DB_HOST', 'localhost')}:{os.getenv('DB_PORT', '6543')}/{os.getenv('DB_NAME', 'experiment')}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

def create_app():
    print("Creating app")
    print(os.getenv('DB_USERNAME'))
    app = Flask(__name__)
    app.config.from_object(Config)

    PrometheusMetrics(app)

    db.init_app(app)

    from .routes.test import test
    app.register_blueprint(test)

    return app