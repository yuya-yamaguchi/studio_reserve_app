module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
  def rescue404(e)
    @exception = e
    error_log = ErrorLog.new
    error_log.create_log(params, e, request.remote_ip)
    render template: "errors/page_notfound"
  end

  def rescue500(e)
    @exception = e
    error_log = ErrorLog.new
    error_log.create_log(params, e, request.remote_ip)
    render template: "errors/system_error"
  end
end