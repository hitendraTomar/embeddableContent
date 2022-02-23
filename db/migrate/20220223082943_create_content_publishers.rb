class CreateContentPublishers < ActiveRecord::Migration[7.0]
  def change
    create_table :content_publishers do |t|
      t.text :header
      t.text :footer
      t.references :user, null: false, foreign_key: true
      t.references :embeddable_content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
