class AddStatusToAnswers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :answers do |t|
      t.boolean :is_best, default: false
    end
  end
end
