class ApplicationController < ActionController::Base

  def hello
    render html: "auto pull test in deployment ENV"
  end

end
