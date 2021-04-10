class TargetDir < ApplicationRecord
  has_many :downloads, dependent: :destroy
end
