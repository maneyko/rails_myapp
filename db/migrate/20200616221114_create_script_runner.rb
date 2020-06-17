class CreateScriptRunner < ActiveRecord::Migration[5.2]
  def change

    create_table :script_runner_names, id: :serial, force: :cascade do |t|
      t.text :name, null: false
      t.index :name, unique: true
    end

    create_table :script_runner_results do |t|
      t.string :result
      t.column :status, :integer, default: 0
      t.integer :script_runner_id, null: false
      t.index [:script_runner_id]
    end

    create_table :script_runners do |t|
      t.integer :script_runner_name_id, null: false
      t.index [:script_runner_name_id]
    end

    add_foreign_key "script_runners", "script_runner_names", exclude_index: true

    ScriptRunnerName.create!(name: "my_task")
  end

end
