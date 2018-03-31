# to_query

ActiveSupport to_query method for Crystal. Fast implementation.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  to_query:
    github: kostya/to_query
```

## Usage

```crystal
require "to_query"

{data: "⬤"}.to_query # => "data=%E2%AC%A4"

{"x" => {"y" => "z"}}.to_query #=> "x%5By%5D=z"

h = { "n1"  => {"value" => "1", "path" => "/cookies", "http_only" => "true", "domain" => "127.0.0.1"},
  "n2"  => {"value" => "2", "path" => "/", "http_only" => "true", "domain" => "127.0.0.1"},
  "url" => "http://127.0.0.1/get"}

h.to_query #=> "n1%5Bvalue%5D=1&n1%5Bpath%5D=%2Fcookies&n1%5Bhttp_only%5D=true&n1%5Bdomain%5D=127.0.0.1&n2%5Bvalue%5D=2&n2%5Bpath%5D=%2F&n2%5Bhttp_only%5D=true&n2%5Bdomain%5D=127.0.0.1&url=http%3A%2F%2F127.0.0.1%2Fget"

```
