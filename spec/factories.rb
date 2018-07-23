FactoryBot.define do
  factory :user do
    id 1
    username 'temp'
    password 'temp'
    email 'temp@temp.com'
    phone '1234567890'
  end

  factory :upload do
    user_id 1
    file_name 'anyfile.txt'
    file_type 'text'
    path 'storage/73158d9cfbf862ba6b9ace7e5e639403.txt'
    uuid '73158d9cfbf862ba6b9ace7e5e639403'
  end
end
