from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI']='postgresql://postgres:1@localhost:5432/courseonline?sslmode=disable'
db = SQLAlchemy(app)

#table pengguna
class Pengguna(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    nama = db.Column(db.String)
    password = db.Column(db.String, nullable=False)
    role = db.Column(db.String, nullable=False)
    
def login():
    username = request.authorization.get("username")
    password = request.authorization.get("password")
    
    try:
        global user
        user = Pengguna.query.filter_by(email=username).first_or_404()
    except:
        return {
            'error message' : 'Hayo salah.'
        }
        
    if user.password == password:
        if user.tipe == 'Admin':
            return 'Admin'
        elif user.tipe == 'Student':
            return 'Student'
    else:
        return 'Password salah!'

#tabel course
class Course(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    Nama = db.Column(db.String, nullable=False)
    deskripsi = db.Column(db.String, nullable=False)
    kategori = db.Column(db.String, nullable=False)
    student = db.relationship('Coursedata', backref='course', lazy='dynamic')

# tabel course data
class Coursedata(db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("pengguna.id"), nullable=False)
    course_id = db.Column(db.Integer, db.ForeignKey("course.id"), nullable=False)
    status = db.Column(db.String, nullable=False) 

# tabel pre-requsite
class Prequisite(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    course_id = db.Column(db.Integer, db.ForeignKey("course.id"))
    prequisite_id = db.Column(db.Integer, db.ForeignKey("course.id"))

#endpoint 
@app.route('/user/regis', methods=['POST'])
def create_newuser():
    data=request.get_json()
    new_user = Pengguna(
        id = data.get('id'),
        nama = data.get('nama'),
        password = data.get('password'),
        role = data.get('role')
    )
    db.session.add(new_user)
    db.session.commit()
    return {"message": "Hore! Anda berhasil mendaftar."}

@app.route('/user/update/<id>', methods=['PUT'])
def create_updateuser(id):
    user = Pengguna.query.filter_by(id=id).first_or_404()
    data=request.get_json()
    user.id = data.get('id'),
    user.nama = data.get('nama'),
    user.pasword = data.get('password'),
    user.role = data.get('role')
    
    db.session.add(user)
    db.session.commit()
    return {"message": "Hore! Anda berhasil mengupdate data."}

if __name__ == '__main__':
    app.run(debug=True)

with app.app_context(): 
    db.create_all()
    db.session.commit()
    