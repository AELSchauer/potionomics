class Cauldron < ApplicationRecord
  has_many :cupboard_cauldrons
  has_one :upgrade, class_name: "Cauldron", foreign_key: "upgrade_id"
  belongs_to :downgrade, class_name: "Cauldron", optional: true
end
