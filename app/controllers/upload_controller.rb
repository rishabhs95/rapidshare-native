class UploadController < ApplicationController
  before_action :authorize, :only => [:index, :new, :create, :edit, :update, :destroy]

  # GET list of all entities
  def index
    @files = current_user.uploads
    @files = Upload.by_user(current_user)
  end

  # GET HTML for POST to #create
  def new
  end

  # POST data from #new
  def create
    file = params[:upload][:file]
    custom_name = params[:custom_file_name]
    Upload.save_file(file, custom_name, current_user.id)
    flash[:notice] = "File uploaded."
    redirect_to "/upload"
  end

  # GET resource by id
  def show
    uuid = params[:id]
    file = Upload.by_user(current_user).with_hash(uuid).first
    details = file.path.split('.')
    extension = details[1]
    file_name = "#{file.file_name}.#{extension}"
    send_file file.path, filename: file_name, disposition: 'attachment' unless file.nil?
    # send_file(
    #   file.path,
    #   filename: file.file_name,
    #   type: file.file_type
    # ) unless file.nil?
  end

  # GET resource by id
  def _show
    uuid = params[:uuid]
    file = Upload.with_hash(uuid).first
    details = file.path.split('.')
    extension = details[1]
    file_name = "#{file.file_name}.#{extension}"
    send_file file.path, filename: file_name, disposition: 'attachment' unless file.nil?
  end

  # GET HTML for PUT/PATCH to #update
  def edit
  end

  # PUT/PATCH resource by id
  def update
    uuid = params[:id]
    new_name = params[:file_name]
    upload = Upload.by_user(current_user).with_hash(uuid).first
    upload.file_name = new_name
    upload.save
    flash[:notice] = "File updated."
    redirect_to "/"
  end

  # DELETE resource by id
  def destroy
    uuid = params[:id]
    upload = Upload.by_user(current_user).with_hash(uuid).first
    file = upload.path
    File.delete(file) if File.exist?(file)
    upload.destroy
    flash[:notice] = "File deleted."
    redirect_to "/"
  end
end
