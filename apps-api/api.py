from flask import Flask, jsonify, request
from database.database import Database

app = Flask(__name__)

@app.route('/')
def home():
    return '<h1>Flask REST API</h1>'

if __name__ == '__main__':
    app.run(debug=True)

database = Database("mongodb://localhost:27017/")
if not app.debug:
    database.connect()







