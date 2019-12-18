class TopController < ApplicationController

  def index
    @studios = Studio.all
  end

end
