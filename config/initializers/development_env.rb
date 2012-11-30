unless Rails.env.production?
  ENV['SECRET_CODE'] = "secret"
  ENV['IUBUENDA_POLICY'] = 'http://www.iubenda.com/privacy-policy' #in production replace this URL with your privacy policy URL
end