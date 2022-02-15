class JwtService

  def self.encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def self.decoded_token(auth_header)
    return nil unless auth_header

    begin
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
    rescue StandardError => e
      # Log error message e.message
    end
  end
end