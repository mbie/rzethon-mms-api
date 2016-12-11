# Submit current node to known host after application initialization
base_host = ENV["BASE_NODE_HOST"] || "http://localhost:3000"
current_host = ENV["CURRENT_NODE_HOST"] || "http://localhost:3001"
name = ENV["CURRENT_NODE_NAME"] || "MARS#2.3"

# if Node.count.zero? 
  # NodeSubmissionWorker.perform_async(base_host, current_host, name)
# end
