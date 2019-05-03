class Category < ApplicationRecord
    before_validation :strip_whitespace
    validates :name, presence: true,uniqueness: true
    private
    def strip_whitespace
        self.name = self.name.strip unless self.name.nil?
      end
end
