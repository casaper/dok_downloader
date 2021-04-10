class Source < ApplicationRecord
  has_many :downloads, dependent: :nullify
end
