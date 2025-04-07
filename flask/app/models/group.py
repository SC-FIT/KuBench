from app import db
from sqlalchemy import Sequence, Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime


class Group(db.Model):
    __tablename__ = 'group'

    id = Column(Integer, Sequence('group_id_seq'), primary_key=True)
    name = Column(String, nullable=False)
    contract_signed = Column(db.DateTime, nullable=False)  # Use DateTime for dates and times
    contract_number = Column(Integer)
    institute_name = Column(String)
    institute_address_name = Column(String, nullable=False)
    institute_address_number = Column(String)
    institute_postal_code = Column(String, nullable=False)
    province = Column(String)
    city = Column(String, nullable=False)
    country = Column(String, nullable=False)
    vat = Column(String)
    institute_phone = Column(String, nullable=False)
    institute_email = Column(String, nullable=False)
    state_id = Column(Integer, ForeignKey('usergroupstate.id'), nullable=False)
    priority = Column(Float, nullable=False)

    # state = relationship("Usergroupstate", back_populates="groups")
    # users = relationship("User", back_populates="group")

def __init__(self, **kwargs):
    super().__init__(**kwargs)
