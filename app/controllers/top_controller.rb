class TopController < ApplicationController

  def index
    begin
      @studios = Studio.all
    rescue => e
      error_log = ErrorLog.new
      error_log.create_log(params, e, request.remote_ip)
      render template: "common/error1"
    end
  end

end
