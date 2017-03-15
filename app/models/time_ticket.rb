class TimeTicket < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :arrival
  validates_presence_of :departure
  validates_presence_of :date
  validates_presence_of :user_id

  def work_time
    if self.is_finished?
      ((self.departure.to_i - self.arrival.to_i) / 1.second).round
    else
      time = Time.now
      ((time.to_i - self.arrival.to_i) / 1.second).round
    end
  end
end
