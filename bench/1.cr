require "../src/to_query"

t1 = Time.now

objs = {
  { {jo: nil}, 100000 },
  { {bla: 1}, 100000 },
  { {"key" => "value"}, 100000 },
  { {"key" => {"super" => [1, 2, 3], "missing_date" => {data: false}}}, 20000 },
  { {"n1"  => {"value" => "1", "path" => "/cookies", "http_only" => "true", "domain" => "127.0.0.1"},
     "n2"  => {"value" => "2", "path" => "/", "http_only" => "true", "domain" => "127.0.0.1"},
     "url" => "http://127.0.0.1/get"}, 10000 },
}

objs.each do |(obj, count)|
  t = Time.now
  p obj
  p obj.to_query
  s = 0_u64

  count.times do
    s += obj.to_query.bytesize
  end

  p s
  p Time.now - t
  p "=" * 50
end

p Time.now - t1
