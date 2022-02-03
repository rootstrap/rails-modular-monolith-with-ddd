class ApplicationController < ActionController::Base
  prepend_view_path(Dir.glob(Rails.root.join('components/*/app/views')))
end
