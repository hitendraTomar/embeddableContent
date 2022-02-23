class CreateEmbeddableContents < ActiveRecord::Migration[7.0]
  def change
    create_table :embeddable_contents do |t|
      t.string :title
      t.text :body
      t.text :header
      t.text :footer
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
