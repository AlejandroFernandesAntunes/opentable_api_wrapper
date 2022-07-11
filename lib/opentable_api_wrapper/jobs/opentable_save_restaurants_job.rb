# frozen_string_literal: true

require 'sidekiq'
require 'activerecord-import'

class OpentableSaveRestaurantsJob < ApplicationJob
  queue_as :ot_save_results

  def perform(restaurants_array)
    new_restaurants =
      restaurants_array.map do |restaurant_json|
        stripped_json =
          restaurant_json.except(
            'profile_photo',
            'hours_raw',
            'latitude',
            'longitude'
          )
        ot_restaurant = OpenTableRestaurant.new(stripped_json)
        ot_restaurant.profile_photo = restaurant_json['profile_photo']
        ot_restaurant.hours_raw = restaurant_json['hours_raw']
        ot_restaurant.latitude = restaurant_json['latitude']
        ot_restaurant.longitude = restaurant_json['longitude']
        ot_restaurant
      end

    OpenTableRestaurant.import(
      new_restaurants,
      on_duplicate_key_update: {
        columns:
          OpenTableRestaurant
            .attribute_names
            .map(&:to_sym)
            .excluding(:id, :created_at, :updated_at, :aux_composed_id),
        conflict_target: 'aux_composed_id'
      }
    )
  end
end
