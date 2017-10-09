require 'json'
require 'rack/app'
require 'awesome_print'

class MyApp < Rack::App

  def calculatePi()
    #
    # Calculate Pi:
    # Pursposefully not using the Brent-Salamin algorithm, as a slower method is preferred here.
    num = 4.0
    pi = 0
    plus = true

    den = 1
    while den < 2500000
      if plus
        pi = pi + num/den
        plus = false
      else
        pi = pi - num/den
        plus = true
      end
      den = den + 2
    end

    pi
  end

  headers 'Access-Control-Allow-Origin' => '*', 'Content-Type' => 'application/json'

  get '/' do
    beginTask = Time.now.to_f
    hostname  = `hostname`.gsub("\n","")
    timestamp = Time.now.to_i
    result    = { hostname: hostname, result: calculatePi() }
    endTask   = Time.now.to_f

    result["jobDuration"] = endTask - beginTask

    result
  end

end

# for more check out how-to
run MyApp