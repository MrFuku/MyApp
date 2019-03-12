# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class DevisePreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(name:"jack", email: "jack@example.com")
    Devise::Mailer.confirmation_instructions(user, Devise.friendly_token[0,20])
  end
end
