module CupboardConcern
  extend ActiveSupport::Concern

  included do
    before_action :current_cupboard
  end

  def current_cupboard
    @current_cupboard ||= Cupboard.find(params['cupboard_id'])
  end
end
