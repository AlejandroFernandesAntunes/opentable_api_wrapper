# frozen_string_literal: true

require 'activerecord'
require 'sidekiq'

class OpentableUpdateDirJob < ApplicationJob
  queue_as :default

  def perform
    OpentableScrapper.new.update_local_directory
  end
end
