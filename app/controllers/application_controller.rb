class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  SITE_NAME = "ブランド物iPhoneケース"
  $site_title = SITE_NAME;
  $html_title = SITE_NAME;
end
