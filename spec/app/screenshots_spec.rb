require 'spec_helper'

describe App::App do
  include Rack::Test::Methods

  def app
    Padrino.application
  end

  it "screenshots" do
    get "/api/screenshots"
    last_response.status.should == 200
    last_response.body.should == [
      { id: 1, name: "test", status: 0, casperscript: "// Script" },
      { id: 2, name: "Test", status: 1, casperscript: "// test" }
      ].to_json
  end
end
