require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET new" do
    before do
      get :new
    end
    it { expect(response).to have_http_status(200) }
    it { expect(response.content_type.to_s).to eq "text/html" }
    it { expect(response).to render_template :new }
  end

  describe "POST create" do
    context 'with valid credentials' do
      before do
        credentials = { username: 'test-user',
                        name: 'test-user',
                        email: 'test_user@test.com',
                        phone: '1234567890',
                        password: 'test-user',
                        password_confirmation: 'test-user'}
        post :create, params: { user: credentials }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to root_path }
      it { expect(User.count).to eq 1 }
    end

    context 'with invalid credentials' do
      before do
        credentials = { name: 'test-user',
                        email: 'test_user@test.com',
                        phone: '1234567890',
                        password: 'test-user',
                        password_confirmation: 'test-user'}
        post :create, params: { user: credentials }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to signup_path }
      it { expect(User.count).to eq 0 }
    end
  end

  describe "GET show" do
    context 'when user is logged in' do
      before do
        sign_in
        get :show
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end

    context 'when user is logged out' do
      before do
        get :show
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "GET edit" do
    context 'when user is logged in' do
      before do
        sign_in
        get :edit
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end

    context 'when user is logged out' do
      before do
        get :edit
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "PATCH update" do
    context 'when user is logged in' do
      before do
        sign_in
        patch :update, params: { name: 'test2', phone: '1234' }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to user_path }
    end

    context 'when user is logged out' do
      before do
        patch :update
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end
end
