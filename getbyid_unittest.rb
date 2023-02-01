require 'minitest/autorun'
require 'net/http'
require 'json'

class GETBYIDTest < Minitest::Test
  @@_URI = URI('http://localhost:8080/getbyid/63cd9c2b5976c9750dd64786')

  def test_rescode
    response = Net::HTTP.get_response(@@_URI)

    assert_equal '200', response.code
  end
  def test_rescode_wrongid
    response = Net::HTTP.get_response(URI('http://localhost:8080/getbyid/63cd9ccd5976c9750dd64786'))

    assert_equal '404', response.code
  end
  def test_body
    response = Net::HTTP.get_response(@@_URI)
    
    expected_body = "{\"_id\":\"63cd9c2b5976c9750dd64786\",\"title\":\"iahd\xC3\xBCoeif\",\"ingredients\":[{\"id\":\"1\",\"ingredient\":\"esuhf\",\"amount\":\"hello\"},{\"id\":\"2\",\"ingredient\":\"ejli\",\"amount\":\"hjijil\"}],\"preparation\":\"yolo\",\"selected\":1,\"date\":\"2023-01-22T20:27:23.32Z\",\"__v\":0}"
    
    assert_equal JSON.parse(expected_body), JSON.parse(response.body)
  end
  def test_restime
    start_time = Time.now
    response = Net::HTTP.get_response(@@_URI)
    end_time = Time.now
    response_time = (end_time - start_time) * 1000

    assert response_time >= 1, "Expected response time >= 40ms, got #{response_time}ms"
    assert response_time <= 60, "Expected response time <= 60ms, got #{response_time}ms"
  end
  def test_ressize
    response = Net::HTTP.get_response(@@_URI)
    response_size = response.body.size

    assert response_size >= 230, "Expected response size >= 230B, got #{response_size}B"
    assert response_size <= 260, "Expected response size <= 260B, got #{response_size}B"
  end
  def test_avrgrestime
    restimes = 0
    for i in 1..20
        start_time = Time.now
        response = Net::HTTP.get_response(@@_URI)
        end_time = Time.now
        response_time = (end_time - start_time) * 1000
        restimes += response_time
    end
    restimes /= 20
    assert restimes <= 30, "Expected response time <= 60ms, got #{response_time}ms"
  end
end
class GETALLTest < Minitest::Test
  @@_URI = URI('http://localhost:8080/get')

  def test_rescode
    response = Net::HTTP.get_response(@@_URI)

    assert_equal '200', response.code
  end
  def test_avrgrestime
    restimes = 0
    for i in 1..20
        start_time = Time.now
        response = Net::HTTP.get_response(@@_URI)
        end_time = Time.now
        response_time = (end_time - start_time) * 1000
        restimes += response_time
    end
    restimes /= 20
    assert restimes <= 25, "Expected response time <= 25ms, got #{response_time}ms"
  end
  def test_body 
    response = Net::HTTP.get_response(@@_URI)
    
    expected_body = "{\"__v\":0,\"_id\":\"63cd9c2b5976c9750dd64786\",\"date\":\"2023-01-22T21:27:23.32+01:00\",\"ingredients\":[{\"amount\":\"hello\",\"id\":\"1\",\"ingredient\":\"esuhf\"},{\"amount\":\"hjijil\",\"id\":\"2\",\"ingredient\":\"ejli\"}],\"preparation\":\"yolo\",\"selected\":1,\"title\":\"iahd\xC3\xBCoeif\"}"
    
    assert_equal JSON.parse(expected_body), JSON.parse(response.body)[0]
  end
end
class SELECTTest < Minitest::Test
  @@_URI = URI('http://localhost:8080/select/63d5819cb0b67c1b476fdcb0')

  def test_rescode
    response = Net::HTTP.get_response(@@_URI)

    assert_equal '200', response.code
  end
  def test_avrgrestime
    restimes = 0
    for i in 1..20
        start_time = Time.now
        response = Net::HTTP.get_response(@@_URI)
        end_time = Time.now
        response_time = (end_time - start_time) * 1000
        restimes += response_time
    end
    restimes /= 20
    assert restimes <= 55, "Expected response time <= 55ms, got #{response_time}ms"
  end
  def test_body 
    response = Net::HTTP.get_response(@@_URI)
    
    expected_body = "{\"MatchedCount\":1,\"ModifiedCount\":1,\"UpsertedCount\":0,\"UpsertedID\":null}"
    assert_equal expected_body, response.body
  end
end
class DESELECTTest < Minitest::Test
  @@_URI = URI('http://localhost:8080/deselect/63d5819cb0b67c1b476fdcb0')

  def test_rescode
    response = Net::HTTP.get_response(@@_URI)

    assert_equal '200', response.code
  end
  def test_avrgrestime
    restimes = 0
    for i in 1..20
        start_time = Time.now
        response = Net::HTTP.get_response(@@_URI)
        end_time = Time.now
        response_time = (end_time - start_time) * 1000
        restimes += response_time
    end
    restimes /= 20
    assert restimes <= 55, "Expected response time <= 55ms, got #{response_time}ms"
  end
  def test_body 
    response = Net::HTTP.get_response(@@_URI)
    
    expected_body = "{\"MatchedCount\":1,\"ModifiedCount\":1,\"UpsertedCount\":0,\"UpsertedID\":null}"
    
    assert_equal expected_body, response.body
  end
end