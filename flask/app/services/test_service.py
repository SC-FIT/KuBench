import csv
import os
from datetime import datetime
import tempfile
from zipfile import ZipFile

from werkzeug.utils import secure_filename

from app import db

class TestService:
    def __init__(self, user_repo, group_repo, usergroupstate_repo):
        self.user_repo = user_repo
        self.group_repo = group_repo
        self.usergroupstate_repo = usergroupstate_repo
        self.temp_files_by_original_filename = {}

    def handle_file_upload(self, file):
        try:
            self.open_zip_file(file)
            self.import_from_file()
        finally:
            self.cleanup_temp_files()

    def open_zip_file(self, file):
        try:
            with ZipFile(file) as zip_ref:
                for file_info in zip_ref.infolist():
                    if file_info.filename.endswith('.csv'):
                        with zip_ref.open(file_info) as extracted_file:
                            temp_file = self.create_temp_file(file_info.filename)
                            with open(temp_file, 'wb') as temp_out:
                                temp_out.write(extracted_file.read())
        except Exception as e:
            raise RuntimeError(f"Error extracting ZIP file: {e}")

    def create_temp_file(self, file_name):
        temp_file = tempfile.NamedTemporaryFile(delete=False, prefix='tmp_', suffix=f"_{secure_filename(file_name)}")
        self.temp_files_by_original_filename[file_name] = temp_file.name
        return temp_file.name

    def get_temp_file(self, file_name):
        return self.temp_files_by_original_filename.get(file_name)

    def cleanup_temp_files(self):
        for file_path in self.temp_files_by_original_filename.values():
            try:
                os.remove(file_path)
            except Exception as e:
                print(f"Failed to delete temp file {file_path}: {e}")
        self.temp_files_by_original_filename.clear()

    def import_from_file(self):
        self.insert_group_state()
        self.insert_group()
        self.insert_user()

    def insert_group_state(self):
        file_path = self.get_temp_file("usergroupstate.csv")
        if not file_path:
            return

        with open(file_path, mode='r', encoding='utf-8') as csv_file:
            csv_reader = csv.reader(csv_file)
            next(csv_reader)  # Skip header
            try:
                for line in csv_reader:
                    state = self.usergroupstate_repo(
                        id=int(line[0]),
                        label=line[1]
                    )
                    db.session.merge(state)
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                raise RuntimeError(f"Error inserting group states: {e}")

    def insert_group(self):
        file_path = self.get_temp_file("group.csv")
        if not file_path:
            return

        with open(file_path, mode='r', encoding='utf-8') as csv_file:
            csv_reader = csv.reader(csv_file)
            next(csv_reader)  # Skip header
            try:
                for line in csv_reader:
                    group = self.group_repo(
                        id=int(line[0]),
                        name=line[1],
                        contract_signed=datetime.strptime(line[2], '%Y-%m-%d %H:%M:%S.%f'),
                        contract_number=int(line[3]),
                        institute_name=line[4],
                        institute_address_name=line[5],
                        institute_address_number=line[6],
                        institute_postal_code=line[7],
                        province=line[8],
                        city=line[9],
                        country=line[10],
                        vat=line[11],
                        institute_phone=line[12],
                        institute_email=line[13],
                        state_id=int(line[14]),
                        priority=float(line[16])
                    )
                    db.session.merge(group)
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                raise RuntimeError(f"Error inserting groups: {e}")

    def insert_user(self):
        file_path = self.get_temp_file("user.csv")
        if not file_path:
            return

        with open(file_path, mode='r', encoding='utf-8') as csv_file:
            csv_reader = csv.reader(csv_file)
            next(csv_reader)  # Skip header
            try:
                for line in csv_reader:
                    user = self.user_repo(
                        id=int(line[0]),
                        group_id=int(line[1]),
                        state_id=int(line[2]),
                        name=line[3],
                        surname=line[4],
                        login=line[5],
                        passwd=line[6],
                        email=line[7],
                        phone=line[8],
                        is_dsm_admin=line[9].lower() == 'true',
                        is_group_admin=line[10].lower() == 'true',
                        is_planner=line[11].lower() == 'true',
                        is_support_tech=line[12].lower() == 'true',
                        photo=line[13]
                    )
                    db.session.merge(user)
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                raise RuntimeError(f"Error inserting users: {e}")
