# frozen_string_literal: true

require 'sidekiq'

class OpentableUpdateDirJob < ActiveJob::Base
  queue_as :default

  def perform
    OpentableScrapper.new.update_local_directory
  end
end
