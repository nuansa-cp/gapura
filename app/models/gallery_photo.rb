# frozen_string_literal: true

class GalleryPhoto < ApplicationRecord
  default_scope { order('created_at DESC') }

  has_one :image, as: :imageable, dependent: :destroy
  belongs_to :event, foreign_key: :year, primary_key: :year, touch: true

  accepts_nested_attributes_for :image,
                                reject_if: :all_blank, allow_destroy: true

  # rubocop:todo Naming/BlockParameterName
  # rubocop:todo Naming/VariableName
  after_create :fill_image_link,
               if:
                 proc { |galleryPhoto|
                   # rubocop:enable Naming/VariableName
                   # rubocop:todo Naming/VariableName
                   galleryPhoto.image_link.blank?
                   # rubocop:enable Naming/VariableName
                 }
  # rubocop:enable Naming/BlockParameterName

  private

  def fill_image_link
    if image.nil?
      errors.add(
        :image_link,
        'have to be provided if you are not attaching an image'
      )
      raise ActiveRecord::RecordInvalid
    end

    self.image_link =
      Rails.application.routes.url_helpers.serve_image_url(image)
    save
  end
end
