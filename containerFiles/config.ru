require 'sinatra'
configure { set :server, :puma }

require 'json'
require 'awesome_print'

class MyApp < Sinatra::Base

  def calculatePi()
    #
    # Calculate Pi:
    # Pursposefully not using the Brent-Salamin algorithm, as a slower method is preferred here.

    num  = 4.0
    pi   = 0
    plus = true

    den = 1
    while den < 2500000
      if plus
        pi   = pi + num/den
        plus = false
      else
        pi   = pi - num/den
        plus = true
      end
      den = den + 2
    end

    pi
  end

  get '/' do
    content_type :json

    beginTask = Time.now.to_f
    hostname  = `hostname`.gsub("\n","")
    timestamp = Time.now.to_i
    
    response  = { hostname: hostname, result: calculatePi() }
    endTask   = Time.now.to_f
    response["jobDuration"] = endTask - beginTask

    response.to_json
  end

end

map('/')       { run MyApp  }