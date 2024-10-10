class Task < ApplicationRecord
    STATUSES = { incomplete: 'incomplete', complete: 'complete' }
  
    validates :status, inclusion: { in: STATUSES.values }
  
    before_create :set_default_status
  
    private
  
    def set_default_status
      self.status ||= STATUSES[:incomplete]
    end
  end
  