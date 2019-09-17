class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :place
    after_create :send_comment_email

    RATINGS = {
        'one star': '1_star',
        'two stars': '2_stars',
        'three stars': '3_stars',
        'four stars': '4_stars',
        'five stars': '5_stars'
      }


   def humanized_rating
    RATINGS.invert[self.rating]
   end
   def get_stars 
      num_stars = self.rating.scan(/(\d+)/)
      if num_stars then
        num_stars = num_stars.pop.pop.to_i
      else 
        num_stars = 0
      end
      stars = []
      5.times do |i|
        if i+1 <= num_stars then
          stars << 1
        else
          stars << 0
        end
      end
      return stars
   end
   def send_comment_email
    NotificationMailer.comment_added(self).deliver_now
   end
  end  