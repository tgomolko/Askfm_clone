class Question < ApplicationRecord
  belongs_to :user, optional: true

  validates :question, :length => {:maximum => 300}, presence: true
end
