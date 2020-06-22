class Statistic < ApplicationRecord
    validates :date, presence: true

    before_save :default_values
    def default_values
      self.click  ||= 0
      self.view  ||= 0 
      self.play  ||= 0
      self.pause  ||= 0 
      self.add  ||= 0 
      self.remove  ||= 0 
      self.download  ||= 0 
      self.select  ||= 0 
      self.load  ||= 0 
      self.scroll  ||= 0 
    end
end
