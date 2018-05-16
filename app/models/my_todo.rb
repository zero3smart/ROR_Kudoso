class MyTodo < ActiveRecord::Base
  belongs_to :member
  belongs_to :todo_schedule
  has_one :todo, through: :todo_schedule
  has_one :family, through: :member

  validates_presence_of :todo_schedule, :member_id, :member
  before_save :apply_kudos

  validate :due_times

  def required?
    todo.required
  end
  private

  def due_times
    if due_time.present? && ( due_time.to_date != due_date.to_date )
      self.errors.add(:due_time, "must be on the same day as due date.  Due time = #{due_time.localtime}  Due date = #{due_date}")
    end
  end

  def apply_kudos
    if self.complete_changed? &&  self.todo.kudos.present?
      if self.complete?
        logger.debug "Adding #{self.todo.kudos} to #{self.member.full_name}"
        member.update_attribute(:kudos,(member.kudos + self.todo.kudos) )
      else
        if self.persisted? # Only deduct kudos if we had previously saved
          logger.debug "Removing #{self.todo.kudos} to #{self.member.full_name}"
          member.update_attribute(:kudos,(member.kudos - self.todo.kudos) )
        end
      end
    end
  end
end