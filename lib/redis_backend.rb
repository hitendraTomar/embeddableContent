class RedisBackend
  PREFIX = 'i18n'.freeze

  def initialize
    redis_url = ENV.fetch("REDIS_URL") rescue "redis://localhost:6379/1"
    @redis = Redis.new(url: redis_url)
  end

  def with_prefix(key)
    "#{PREFIX}.#{key}"
  end

  def [](key)
    @redis.get(with_prefix(key)) || ""
  end

  def []=(key, value)
    @redis.set with_prefix(key), value
  end

  def keys
    @redis.keys with_prefix('*')
  end

  def clear_old_entries
    keys_to_delete = keys
    @redis.del(*keys_to_delete) unless keys_to_delete.empty?
  end
end
