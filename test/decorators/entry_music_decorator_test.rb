# frozen_string_literal: true

require 'test_helper'

class EntryMusicDecoratorTest < ActiveSupport::TestCase
  def setup
    @entry_music = EntryMusic.new.extend EntryMusicDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
