class Payment::Physical < ApplicationRecord
    belongs_to :payment, optional: true
end