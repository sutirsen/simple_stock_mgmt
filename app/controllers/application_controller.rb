class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def upload_file (upoloadedFileObj)
    originalFileName = upoloadedFileObj.original_filename
    finalFileName = Time.now.to_i.to_s + Random.rand(100).to_s + originalFileName
    File.open(Rails.root.join('public', 'uploads', finalFileName), 'wb') do |file|
      file.write(upoloadedFileObj.read)
    end
    return File.join('/', 'uploads', finalFileName)
  end

  def actual_path (uploadPath)
    if uploadPath[0] == '/'
      uploadPath = uploadPath[1..-1]
    end
    return Rails.root.join('public',uploadPath)
  end
end
