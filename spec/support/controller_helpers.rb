module ControllerHelpers

  def sign_in(user = nil)
    if user.nil?
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end

RSpec.configure do |c|
  c.include ControllerHelpers
end
