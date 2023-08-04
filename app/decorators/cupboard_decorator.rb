class CupboardDecorator < ApplicationDecorator
  decorates :cupboard
  include Draper::LazyHelpers

  def display_name
    object.name || object.created_at.strftime('%B %-d %Y')
  end
end
