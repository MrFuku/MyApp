class ApplicationController < ActionController::Base

  def hello
    render html: "pull test in deployment ENV"
  end

end
