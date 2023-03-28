class Postcode < ApplicationRecord
    has_many :companies, foreign_key: :postcode
end
