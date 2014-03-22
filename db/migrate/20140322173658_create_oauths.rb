class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.string :connect
      t.string :callback

      t.timestamps
    end
  end
end
