module Tokie
  class Client
    include HTTParty
    base_uri 'https://api.opentok.com/hl'
    format :xml

    attr_reader :token

    def initialize(partner_id, partner_secret)
      @partner_id = partner_id
      @partner_secret = partner_secret
    end

    def validate_token
      self.class.headers({'X-TB-TOKEN-AUTH' => token})
      self.class.get('/token/validate')
    end

    def create_session(options = {})
      options.merge!(:partner_id => @partner_id, :location_hint => '')
      self.class.headers({'X-TB-TOKEN-AUTH' => token})
      self.class.post('/session/create', options)
    end

    def generate_token(options = {})
      { :session_id => nil, 
        :permissions => [], 
        :create_time => nil, 
        :expire_time => nil }.merge!(options)

      create_time = options[:create_time] || Time.now
      session_id = options[:session_id] || ''

      data_params = {
        :session_id => session_id,
        :create_time => create_time.to_i,
        :permissions => options[:permissions]
      }

      if !options[:expire_time].nil?
        data_params[:expire_time] = options[:expire_time].to_i
      end

      data_string = Tokie.urlencode(data_params)
      
      meta_string = Tokie.urlencode({
        :partner_id => @partner_id,
        :sdk_version => "tokbox-v#{Version}",
        :sig => sign_string(data_string, @partner_secret)
      })

      @token = "T1==" + Base64.encode64(meta_string + ":" + data_string).gsub("\n", "")
    end

    private

    def sign_string(data, secret)
      digest  = OpenSSL::Digest::Digest.new('sha1')
      OpenSSL::HMAC.hexdigest(digest, secret, data)
    end
  end
end
