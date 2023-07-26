class AddUserToCupboard < ActiveRecord::Migration[7.0]
  def change
    add_reference :cupboards, :user, index: true
  end
end
