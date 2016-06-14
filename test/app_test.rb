require 'test_helper'

class AppTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    Stylio::App
  end

  def test_home_page
    get '/'
    assert last_response.ok?
  end

  def test_elements_page
    get '/elements'
    assert last_response.ok?
  end
end
