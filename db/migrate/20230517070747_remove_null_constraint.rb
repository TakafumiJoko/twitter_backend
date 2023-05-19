class RemoveNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tweets, :message, true
  end
end
