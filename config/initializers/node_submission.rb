# Submit current node to known host after application initialization
base_host = ENV["BASE_NODE_HOST"] || "http://localhost:3000"
current_host = ENV["CURRENT_NODE_HOST"] || "http://localhost:3000"
name = ENV["CURRENT_NODE_NAME"] || "MARS#2.3"

# for demo purposes the index must be global to the application
# and not reinitialized with controller class
NAME_INDEX = {}

NodeSubmissionWorker.perform_async(base_host, current_host, name)
