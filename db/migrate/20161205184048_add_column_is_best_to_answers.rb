class AddColumnIsBestToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :is_best, :boolean, null: false
  end
end
