from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI']='postgresql://postgres:1@localhost:5432/courseonline?sslmode=disable'
#app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://DB_USER:PASSWORD@HOST/DATABASE'
db = SQLAlchemy(app)

#table pengguna
class Pengguna(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nama = db.Column(db.String)
    password = db.Column(db.String, nullable=False)
    role = db.Column(db.Integer, nullable=False)
    
# def login():
#     username = request.authorization.get("username")
#     password = request.authorization.get("password")
    
#     try:
#         global user
#         user = Pengguna.query.filter_by(email=username).first_or_404()
#     except:
#         return {
#             'error message' : 'Hayo salah.'
#         }
        
#     if user.password == password:
#         if user.tipe == 'Admin':
#             return 'Admin'
#         elif user.tipe == 'Member':
#             return 'Member'
#     else:
#         return 'Password salah!'

#tabel course
class Course(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    Nama = db.Column(db.String, nullable=False)
    deskripsi = db.Column(db.String, nullable=False)
    kategori = db.Column(db.Integer, db.ForeignKey("kategori.id"), nullable=False)
    student = db.relationship('Coursedata', backref='course', lazy='dynamic')

# tabel course data
class Coursedata(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("pengguna.id"), nullable=False)
    course_id = db.Column(db.Integer, db.ForeignKey("course.id"), nullable=False)
    status_id = db.Column(db.Integer, db.ForeignKey("status.id"), nullable=False) 
    
#tabel status
class Status(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    status = db.Column(db.String, nullable=False)
    statuses = db.relationship('Coursedata', backref='status', lazy='dynamic')
    
# tabel pre-requsite
class Prequisite(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    course_id = db.Column(db.Integer, db.ForeignKey("course.id"))
    prequisite_id = db.Column(db.Integer, db.ForeignKey("course.id"))

# #tabel kategori
# class Kategori(db.Model):
#     id = db.Column(db.Integer, primary_key=True, nullable=False)
#     nama = db.Column(db.String, nullable=False)
#     course = db.relationship('Course', backref='kategori', lazy='dynamic')
    
# #tabel role
# class Role(db.Model):
#     id = db.Column(db.Integer, primary_key=True, nullable=False)
#     nama_role = db.Column(db.String, nullable=False)
#     pengguna = db.relationship('Pengguna', backref='role', lazy='dynamic')


with app.app_context(): 
    db.create_all()
    db.session.commit()
    
if __name__ == '__main__':
    app.run(debug=True)