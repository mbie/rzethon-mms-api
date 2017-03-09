url = ENV["REDIS_CACHE_URL"] || "redis://localhost:6379/0/cache"
Redis.current = Redis.new(:url => url)
