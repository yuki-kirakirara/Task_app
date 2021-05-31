class Task < ApplicationRecord
  belongs_to :user
   before_save { self.email.downcase! }
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
 
end
