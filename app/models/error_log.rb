class ErrorLog < ApplicationRecord

  def create_log(params, e, remote_ip)
    self.controller = params[:controller]
    self.action     = params[:action]
    self.ip_address = remote_ip
    self.message    = e.message
    self.parameters = params.to_s
    self.save
  end
end
