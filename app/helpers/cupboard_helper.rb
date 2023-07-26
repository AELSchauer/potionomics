module CupboardHelper
  def set_cupboard
    @cupboard = Cupboard.find(params["cupboard_id"])
  end
end
