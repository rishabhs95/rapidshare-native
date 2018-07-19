class Upload < ApplicationRecord
  belongs_to :user

  scope :by_user, -> (user) { where user_id: user.id }
  scope :with_hash, -> (uuid) { where uuid: uuid }
  scope :with_name, -> (filename) { where file_name: filename }

  def self.save_file(file, name, user_id)
    file_details = file.original_filename.split('.')
    content_type = file.content_type
    extension = file_details[1]
    data = file.read
    file_hash = Digest::MD5.hexdigest(data.to_s).to_s
    hashed_name = "#{file_hash}.#{extension}"
    path = File.join("storage", hashed_name)
    new_file = File.open(path, "wb")
    new_file.write(data)
    Upload.create(user_id: user_id, file_name: name, file_type: content_type, path: path, uuid: file_hash)
  ensure
    file.close unless file.nil?
  end
end
