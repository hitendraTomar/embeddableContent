class CreateContentStylesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :content_stylesheets do |t|
      t.references :embeddable_content, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
