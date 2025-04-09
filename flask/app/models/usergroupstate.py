from app import db


class Usergroupstate(db.Model):
    __tablename__ = 'usergroupstate'
    id = db.Column(db.Integer, primary_key=True)
    label = db.Column(db.String, unique=True, nullable=False)

    # groups = db.relationship("Group", back_populates="state")
    # users = db.relationship("User", back_populates="state")

    def __init__(self, **kwargs):
        super().__init__(**kwargs)