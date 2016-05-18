module OrderHelper

  def uberify(url, method)

    case method

      when "GET"
        auth_token = "#{session[:access_token]}"
        url = URI.parse(url)
        req = Net::HTTP::Get.new(url.path)
        req.add_field('Authorization', auth_token)
        session[:access_token] = auth_token

        res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
          http.request(req)
        end
        res

      when "POST"
        uri = URI(url)
        data = { "start_latitude" => params[:start_latitude],
                  "start_longitude" => params[:start_longitude],
                  "end_latitude" => params[:end_latitude],
                  "end_longitude" => params[:end_longitude]
                 }.to_json

        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)
        request["Content-Type"] = 'application/json'
        request["Authorization"] = session[:access_token]
        request.body = data.to_s
        resp = https.request(request)
p "*" * 50
        p resp
        # res = Net::HTTP.post_form(uri, data.to_json)
    end
  end
end
