class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
    #添加电子邮件唯一性约束的迁移
  end
end
