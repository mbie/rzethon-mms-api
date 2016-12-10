# Submit current node to known host after application initialization
host = "http://localhost:3001"
NodeSubmissionJob.perform_in(1.minute, host)
