class RecipeOptimizations::FilterController < ApplicationController
  include CupboardHelper
  before_action :set_cupboard, only: [:index, :show]

  def show
  end
end