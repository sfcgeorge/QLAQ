module UserHelper
  def profile(user)
    %w(open-uri json timeout).each { |it| require it }

    begin
      data = Timeout::timeout(1) {
        open(profile_url(user.try(:email)), &:read)
      }
      data ? JSON.parse(data).fetch('entry', []).fetch(0, {}) : {}
    rescue Exception
      {}
    end
  end

  def profile_url(email)
    require 'digest/md5' unless defined?(Digest::MD5)
    md5 = Digest::MD5.hexdigest(email.to_s.strip.downcase)

    "#{request.ssl? ? 'https://secure' : 'http://www'}.gravatar.com/profile/#{md5}.json"
  end
end
