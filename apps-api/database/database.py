from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

class Database:
    def __init__(self, link):
        self.link = link
        self.client = None
        self.db = None
        self.chats = None
    def connect(self):
        try:
            self.client = MongoClient(self.link)
            self.client.admin.command('ping')
            print("✅ MongoDB succesfully connected!")

            self.db = self.client["anonym_chat"]
            self.chats = self.db["chats"]
        except ConnectionFailure:
            print("❌ MongoDB failed to connect.")
            self.client = None
            self.db = None
            self.chats = None














