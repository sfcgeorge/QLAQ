Refinery::User.class_eval do
    attr_accessor :secret_code
    attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :plugins, :login, :birthday, :secret_code

    validates :birthday, :inclusion => {
                           :in => Time.now.years_ago(25).to_date..Time.now.years_ago(13).to_date,
                           :message => 'must be 13-25 years old'
                         }
    validates :secret_code, :inclusion => {
                              :in => [ENV['SECRET_CODE']],
                              :message => "%{value} is not a valid secret code",
                              :on => :create
                            }

  def to_param
    id
  end
end