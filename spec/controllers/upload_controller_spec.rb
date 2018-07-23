require 'rails_helper'

RSpec.describe UploadController, type: :controller do
  describe "GET index" do
    context 'when user is logged in' do
      before do
        sign_in
        get :index
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq "text/html" }
      it { expect(response).to render_template :index }
    end

    context 'when user is logged out' do
      before do
        get :index
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "GET new" do
    context 'when user is logged in' do
      before do
        sign_in
        get :new
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { expect(response).to render_template :new }
    end

    context 'when user is logged out' do
      before do
        get :new
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "POST create" do
    context 'when user is logged in' do
      before do
        sign_in
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to upload_index_path }
      it { expect(Upload.count).to eq 1 }
    end

    context 'when user is logged out' do
      before do
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to login_path }
      it { expect(Upload.count).to eq 0 }
    end
  end

  describe "GET show" do
    context 'when user is logged in' do
      before do
        sign_in
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
        id = Upload.last.uuid
        get :show, params: { id: id }
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/plain' }
    end

    context 'when user is logged out' do
      before do
        get :show, params: { id: 1 }
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "GET _show" do
    context 'when user is logged in' do
      before do
        sign_in
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
        id = Upload.last.uuid
        get :_show, params: { uuid: id }
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/plain' }
    end
  end

  describe "GET edit" do
    context 'when user is logged in' do
      before do
        sign_in
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
        id = Upload.last.uuid
        get :edit, params: { id: id }
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end

    context 'when user is logged out' do
      before do
        get :edit, params: { id: 1 }
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
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
        id = Upload.last.uuid
        patch :update, params: { id: id }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to root_path }
    end

    context 'when user is logged out' do
      before do
        patch :update, params: { id: 1 }
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end

  describe "DELETE destroy" do
    context 'when user is logged in' do
      before do
        sign_in
        @file = fixture_file_upload('anyfile.txt')
        file = Hash.new
        file['file'] = @file
        post :create, params: { upload: file, custom_file_name: 'anyfile.txt' }
        id = Upload.last.uuid
        delete :destroy, params: { id: id }
      end
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
      it { is_expected.to redirect_to root_path }
    end

    context 'when user is logged out' do
      before do
        delete :destroy, params: { id: 1 }
      end
      it { is_expected.to redirect_to login_path }
      it { expect(response).to have_http_status(302) }
      it { expect(response.content_type.to_s).to eq 'text/html' }
    end
  end
end
