# frozen_string_literal: true

require 'active_record'
require 'geocoder'

class OpenTableRestaurant < ActiveRecord::Base
  Geocoder::reverse_geocoded_by :latitude, :longitude
  before_validation :assign_aux_composed_id

  PICTURE_SIZES_CHART = {
    h: 'huge',
    l: 'large',
    s: 'small',
    le: 'legacy',
    me: 'medium',
    xl: 'xlarge',
    xs: 'xsmall',
    wh: 'wide-huge',
    wl: 'wide-large',
    ws: 'wide-small',
    wm: 'wide-medium',
    wml: 'wide-mlarge',
    wxl: 'wide-xlarge',
    wsm: 'wide-smedium'
  }.freeze

  def assign_aux_composed_id
    self.aux_composed_id = [
      rid,
      latitude,
      longitude,
      name.try(:parameterize)
    ].join
  end

  def picture_url(preferred_size, fallback = nil)
    profile_photo.dig(
      'sizes',
      PICTURE_SIZES_CHART[preferred_size],
      'url'
    ) || profile_photo.dig('sizes', PICTURE_SIZES_CHART[fallback], 'url')
  end
end
