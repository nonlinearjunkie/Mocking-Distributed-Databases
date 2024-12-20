import os
from pymongo import MongoClient
from gridfs import GridFS

# MongoDB connection details
MONGO_URI = "mongodb://localhost:27041"  
DATABASE_NAME = "images_db"  # Database name
ARTICLES_DIR_PATH = "db-generation/articles/"
# Directory containing images
# Replace with the path to your local image directory

# Connect to MongoDB
client = MongoClient(MONGO_URI)
db = client[DATABASE_NAME]
fs = GridFS(db)

def bulk_upload_images(directory):
    if not os.path.exists(directory):
        print(f"Directory {directory} does not exist.")
        return

    files = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    if not files:
        print(f"No files found in directory {directory}.")
        return

    for file_name in files:
        file_path = os.path.join(directory, file_name)
        with open(file_path, "rb") as file:
            if fs.exists({"filename": file_name}):
                print(f"File {file_name} already exists in GridFS. Skipping...")
            else:
                file_id = fs.put(file, filename=file_name)
                print(f"Uploaded {file_name} with file_id {file_id}")

if __name__ == "__main__":
    for dir in os.listdir(ARTICLES_DIR_PATH):
        article_path = os.path.join(ARTICLES_DIR_PATH, dir)
        bulk_upload_images(article_path)
