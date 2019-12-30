# frozen_string_literal: true

require 'test_helper'

class SessionDecoratorTest < ActiveSupport::TestCase
  def setup
    @session = Session.new.extend SessionDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
