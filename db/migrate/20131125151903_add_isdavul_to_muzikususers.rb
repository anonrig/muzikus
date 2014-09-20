class AddIsdavulToMuzikususers < ActiveRecord::Migration
  def change
    add_column :muzikususers, :isdavul, :boolean
    add_column :muzikususers, :isworkshop, :boolean
  end
end
