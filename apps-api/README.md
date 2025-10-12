
Create and activate a virtual environment:
- python3 -m venv venv
- source venv/bin/activate

Install packages run this command: pip install -r requirements.txt

Start mongodb server:
- sudo service mongod start

Run the API:
- python3 api.py


On WSL Ubuntu, you need to install mongodb first:
- curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
- echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
- sudo apt update
- sudo apt install -y mongodb-org
- sudo systemctl start mongod
- sudo systemctl status mongod
