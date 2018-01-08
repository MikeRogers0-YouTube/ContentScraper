class CreatePageContents < ActiveRecord::Migration[5.1]
  def change
    create_table :page_contents do |t|
      t.string :url
      t.json :content

      t.timestamps
    end
  end
end
