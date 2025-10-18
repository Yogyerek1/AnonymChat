from flask import Flask, jsonify, request
from database.database import Database
import uuid

app = Flask(__name__)

database = Database("mongodb://localhost:27017/")
if not app.debug:
    database.connect()


@app.route('/api/createRoom', methods=['POST'])
def createRoom():
    # get JSON data
    data = request.json
    user_id = data.get('user_id')
    room_name = data.get('room_name')

    # if one of the data is empty, nothing happens
    if not user_id or not room_name:
        return jsonify({'message': 'Empty data!'})
    
    # preparing the dictonary
    room = {
        "room_id": str(uuid.uuid4()),
        "room_name": room_name,
        "hoster_account_id": user_id,
        "members": [user_id],
        "messages": []
    }

    # send a response to client
    result = database.db["rooms"].insert_one(room)
    return jsonify({
        'message': 'Room created successfully!',
        'room_id': room["room_id"],
        'room_name': room["room_name"]        
    })
    

if __name__ == '__main__':
    app.run(debug=True)









