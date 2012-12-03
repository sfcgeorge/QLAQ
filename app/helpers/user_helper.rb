module UserHelper
  def profile(user)
    %w(open-uri json timeout).each { |it| require it }

    begin
      @data = Timeout::timeout(1) {
        open(profile_url(user.try(:email)), &:read)
      } if @data.nil?

      @data ? JSON.parse(@data).fetch('entry', []).fetch(0, {}) : {}
    rescue Exception
      {}
    end
  end

  def profile_url(email)
    require 'digest/md5' unless defined?(Digest::MD5)
    md5 = Digest::MD5.hexdigest(email.to_s.strip.downcase)

    "#{request.ssl? ? 'https://secure' : 'http://www'}.gravatar.com/profile/#{md5}.json"
  end

  def safe_age(user)
    require 'digest/md5' unless defined?(Digest::MD5)
    seed = Digest::MD5.hexdigest(user.created_at.to_s.strip).to_i(16)
    rands = Random.new(seed)

    shifted_birthday = user.birthday + rands.rand(0..6).days

    age(shifted_birthday)
  end

  private
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
