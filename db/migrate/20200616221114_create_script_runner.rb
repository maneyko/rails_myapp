class CreateScriptRunner < ActiveRecord::Migration[5.2]
  def change

    create_table :script_runners do |t|
      t.text :name, null: false
      t.index :name, unique: true
    end

    create_table :script_runner_jobs do |t|
      t.integer :script_runner_id, null: false
      t.column :status, :integer, default: 0
      t.string :result
      t.index [:script_runner_id]
    end

    ScriptRunner.create!(name: "my_task")
  end
end
