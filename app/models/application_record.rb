class ApplicationRecord < ActiveRecord::Base
  
  self.abstract_class = true


  def created_at_str
    return created_at.strftime("%I:%M %p") #hour minute am/pm
  end
  

end
