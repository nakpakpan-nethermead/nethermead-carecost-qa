class CreateSummaryEmails < ActiveRecord::Migration
  def change
    create_table :summary_emails do |t|
      t.string :email
      t.text :message
      t.integer :is_email, :default => 0
      t.integer :user_id
      t.timestamps
    end
  end
end
