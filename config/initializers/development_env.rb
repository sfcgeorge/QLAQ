unless Rails.env.production?
  ENV['SECRET_CODE'] = "secret"
end