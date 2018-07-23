require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET new" do
    before do
      get :new
    end
    it { expect(response).to have_http_status(200) }
    it { expect(response.content_type.to_s).to eq "text/html" }
    it { expect(response).to render_template :new }
  end

  describe "POST create" do
    before do
      post :create
    end
    it { expect(response).to have_http_status(302) }
    it { expect(response.content_type.to_s).to eq "text/html" }
    it { is_expected.to redirect_to login_path }
    it { expect(flash[:error]).to eq 'Login credentials failed' }
  end

  describe "GET destroy" do
    before do
      sign_in
      get :destroy, params: { id: session[:user_id] }
    end
    it { expect(response).to have_http_status(302) }
    it { expect(response.content_type.to_s).to eq "text/html" }
    it { is_expected.to redirect_to login_path }
    it { expect(session[:user_id]).to be_nil }
  end
end
