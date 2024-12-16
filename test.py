from pymongo import MongoClient

# MongoDB connection details
MONGO_URI = "mongodb://localhost:27041"  # Replace with your mongos_router IP and port
DATABASE_NAME = "readersDb"
COLLECTION_NAME = "users"

def connect_and_read():
    try:
        # Establish connection to MongoDB
        client = MongoClient(MONGO_URI)

        # Access the database
        db = client[DATABASE_NAME]

        # Access the collection
        collection = db[COLLECTION_NAME]

        # Query documents (e.g., all documents)
        documents = collection.find({"name":"user31"})  # Use an empty filter {} for all documents

        # Iterate through the documents and print them
        print("Documents in the collection:")
        for doc in documents:
            print(doc)

    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # Close the connection
        client.close()

if __name__ == "__main__":
    connect_and_read()