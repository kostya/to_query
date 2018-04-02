require "uri"

class Object
  def to_query
    String.build do |buf|
      to_query(buf)
    end
  end

  def to_query(prefix : String)
    String.build do |buf|
      to_query(buf, prefix)
    end
  end

  def to_query(io : IO, key)
    URI.escape(key.to_s, io)
    io << '='
    URI.escape(to_s, io)
  end
end

class Array(T)
  def to_query(io : IO, key : String)
    prefix = "#{key}[]"

    if empty?
      nil.to_query(io, prefix)
    else
      self.each_with_index do |value, i|
        io << '&' if i != 0
        value.to_query(io, prefix)
      end
    end
  end
end

struct NamedTuple
  def to_query(io : IO, namespace = nil)
    {% begin %}
    {% c = 0 %}

    {% for key in T %}
      {% if c != 0 %} io << '&' {% end %}
      value = self[{{key.symbolize}}]
      key = {{key.stringify}}
      value.to_query(io, namespace ? "#{namespace}[#{key}]" : key)
      {% c = c + 1 %}
    {% end %}

    {% end %}
  end
end

class Hash(K, V)
  def to_query(io : IO, namespace = nil)
    each_with_index do |(key, value), i|
      io << '&' if i != 0
      value.to_query(io, namespace ? "#{namespace}[#{key}]" : key)
    end
  end
end
