class AssigBugs < ActiveRecord::Migration[7.0]
 
    def change
      add_reference :bugs, :user, index: true
    end

end
