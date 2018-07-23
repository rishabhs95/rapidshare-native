require 'rails_helper'

RSpec.describe Upload, type: :model do
  let(:user) { User.create(username: 'temp-uploader2', name: 'temp-uploader2', email: 'temp-uploader2@temp.com', phone: '12345678902', password: 'temp-uploader2', password_confirmation: 'temp-uploader2') }
  let(:invalid_user) { User.create }

  it "is possible for a valid user" do
    upload = Upload.create(user_id: user.id, file_name: 'test', file_type: 'test', path: 'test', uuid: 'test')
    expect(upload).to be_valid
    expect(Upload.count).to eq 1
  end

  it "is possible multiple times for a valid user" do
    upload1 = Upload.create(user_id: user.id, file_name: 'test1', file_type: 'test1', path: 'test1', uuid: 'test1')
    expect(upload1).to be_valid
    upload2 = Upload.create(user_id: user.id, file_name: 'test2', file_type: 'test2', path: 'test2', uuid: 'test2')
    expect(upload2).to be_valid
    expect(Upload.count).to eq 2
  end

  it "is not valid with invalid arguments" do
    upload = Upload.create
    expect(upload).to_not be_valid
    expect(Upload.count).to eq 0
  end

  it "is not possible without presence of user_id" do
    upload = Upload.create(file_name: 'test', file_type: 'test', path: 'test', uuid: 'test')
    expect(upload).to_not be_valid
    expect(Upload.count).to eq 0
  end

  it "is not possible without presence of path" do
    upload = Upload.create(user_id: user.id, file_name: 'test', file_type: 'test', uuid: 'test')
    expect(upload).to_not be_valid
    expect(Upload.count).to eq 0
  end

  it "is not possible without presence of uuid" do
    upload = Upload.create(user_id: user.id, file_name: 'test', file_type: 'test', path: 'test')
    expect(upload).to_not be_valid
    expect(Upload.count).to eq 0
  end

  it "is not possible for an invalid user" do
    upload = Upload.create(user_id: invalid_user.id, file_name: 'test', file_type: 'test', path: 'test', uuid: 'test')
    expect(upload).to_not be_valid
    expect(Upload.count).to eq 0
  end
end
