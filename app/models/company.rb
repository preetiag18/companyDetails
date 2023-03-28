class Company < ApplicationRecord
    belongs_to :postcode, foreign_key: :postcode
end
