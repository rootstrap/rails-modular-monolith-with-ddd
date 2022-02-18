class ApplicationMailer < ActionMailer::Base
  prepend_view_path(Dir.glob(Rails.root.join('components/*/app/views')))

  default from: 'from@example.com'
  layout 'mailer'
end
