Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']

  # :publishable_key => ENV['pk_test_iqnxAQsZ7YsFt9NvXrt3MBKz'],
  # :secret_key      => ENV['sk_test_lpLc5YPauuJYqfevnpRuJlgv']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]