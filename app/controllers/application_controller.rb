class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Skip CSRF token verification for API requests
  skip_before_action :verify_authenticity_token

  # Handle authentication errors
  rescue_from Devise::UnauthenticatedError do |exception|
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
