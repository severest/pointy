Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '432673961900-nvf198tudqvb4t0ujg41mboph1vlnlh5.apps.googleusercontent.com', 'j6bv5xWKZJeTsxkF9ba4Xzzm', scope: 'profile,email', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google', verify_iss: false
end
