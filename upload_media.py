import os
from pymongo import MongoClient
import gridfs

# MongoDB connection
client = MongoClient("mongodb://127.0.0.1:27017")
db = client["mediaDatabase"]
fs = gridfs.GridFS(db)

# Folder containing images and videos
folder_path = "db-generation/articles"

# Upload files to GridFS
articles_dir_path = "db-generation/articles/"

for dir in os.listdir(articles_dir_path):
    article_path = os.path.join(articles_dir_path, dir)
    for filename in os.listdir(article_path):
    # for filename in os.listdir(folder_path):
        file_path = os.path.join(article_path, filename)
        if filename.endswith((".jpg", ".png", ".mp4", ".mkv", ".avi")):
            with open(file_path, "rb") as file:
                fs.put(file, filename=filename)
                print(f"Uploaded: {filename}")
