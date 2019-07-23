class CreateUser < ActiveRecord::Migration[5.2]
  def change
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    create_table :users do |t|
      t.text :name
      t.text :email

      t.timestamps
    end
  end
end
