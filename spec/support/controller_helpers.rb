module ControllerHelpers
  # rubocop:disable Metrics/AbcSize
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    end
    allow(controller).to receive(:current_user).and_return(user)
  end
end
