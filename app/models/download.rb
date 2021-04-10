class Download < ApplicationRecord
  belongs_to :target_dir
  belongs_to :user, optional: true
end
