class Location < ActiveRecord::Base
    has_many :venues

    def serialize

    end
end
