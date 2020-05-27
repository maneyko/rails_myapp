class CreateVisit < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :ip_address, null: false, limit: 50  # IPv6 maximum length is 50 chars
      t.timestamps
    end
  end
end
