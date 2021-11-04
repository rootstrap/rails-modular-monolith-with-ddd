class ApplicationController < ActionController::Base
  append_view_path(Dir.glob(Rails.root.join('components/*/app/views')))
end
