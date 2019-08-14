class Comment < ApplicationRecord
    belongs_to :user
    belonds_to :place
end
