class Event < ApplicationRecord
    validates :name, :event_type, presence: true
    validates :event_type, inclusion: { in: %w(click view play pause add remove download select load scroll) }

    
end
