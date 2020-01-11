require "./spec_helper"

describe Object do
  describe "to_query" do
    it "returns the query string with a given key" do
      test = "Hello World!"
      test.to_query("greetings").should eq("greetings=Hello+World%21")
    end
  end
end

describe Array do
  describe "to_query" do
    it "display an array as an url_encode string" do
      array = ["michael", "jhon"]
      array.to_query("user").should eq("user%5B%5D=michael&user%5B%5D=jhon")
    end
  end
end

describe Hash do
  describe "to_query" do
    it "returns an url encode string for a hash without namespace" do
      hash = {"name" => "David", "nationality" => "Danish"}
      hash.to_query.should eq("name=David&nationality=Danish")
    end

    it "returns an url encode string for a hash with namespace" do
      hash = {"name" => "David", "nationality" => "Danish"}
      hash.to_query("user").should eq("user%5Bname%5D=David&user%5Bnationality%5D=Danish")
    end
  end
end

describe NamedTuple do
  it "work" do
    {data: "⬤"}.to_query.should eq "data=%E2%AC%A4"
  end

  it "multiple keys" do
    {data: "⬤", bla: 1}.to_query.should eq "data=%E2%AC%A4&bla=1"
  end
end

describe "Hash of Hash" do
  it "work" do
    {"x" => {"y" => "z"}}.to_query.should eq "x%5By%5D=z"
  end

  it "work" do
    {"n1"  => {"value" => "1", "path" => "/cookies", "http_only" => "true", "domain" => "127.0.0.1"},
     "n2"  => {"value" => "2", "path" => "/", "http_only" => "true", "domain" => "127.0.0.1"},
     "url" => "http://127.0.0.1/get"}.to_query.should eq "n1%5Bvalue%5D=1&n1%5Bpath%5D=%2Fcookies&n1%5Bhttp_only%5D=true&n1%5Bdomain%5D=127.0.0.1&n2%5Bvalue%5D=2&n2%5Bpath%5D=%2F&n2%5Bhttp_only%5D=true&n2%5Bdomain%5D=127.0.0.1&url=http%3A%2F%2F127.0.0.1%2Fget"
  end
end
