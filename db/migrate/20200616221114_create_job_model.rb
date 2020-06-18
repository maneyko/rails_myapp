class CreateJobModel < ActiveRecord::Migration[5.2]
  def change

    create_table :jobs do |t|
      t.text :name, null: false
      t.index :name, unique: true
    end

    create_table :job_results do |t|
      t.integer :job_id, null: false
      t.column :status, :integer, default: 0
      t.jsonb :result
      t.timestamps
      t.index [:job_id]
    end

    Job.create!(name: "my_task")
  end
end
