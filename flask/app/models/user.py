from app import db
from sqlalchemy import Sequence
from sqlalchemy.orm import relationship

class User(db.Model):
    __tablename__ = 'user'

    id = db.Column(db.Integer, db.Sequence('user_id_seq'), primary_key=True, nullable=False)
    group_id = db.Column(db.Integer, db.ForeignKey('group.id'), nullable=False)
    state_id = db.Column(db.Integer, db.ForeignKey('usergroupstate.id'), nullable=False)

    name = db.Column(db.String, nullable=False)
    surname = db.Column(db.String, nullable=False)
    login = db.Column(db.String, nullable=False)
    passwd = db.Column(db.String)
    email = db.Column(db.String, nullable=False)
    phone = db.Column(db.String)

    is_dsm_admin = db.Column(db.Boolean, nullable=False, default=False)
    is_group_admin = db.Column(db.Boolean, nullable=False, default=False)
    is_planner = db.Column(db.Boolean, nullable=False, default=False)
    is_support_tech = db.Column(db.Boolean, nullable=False, default=False)

    photo = db.Column(db.String)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
