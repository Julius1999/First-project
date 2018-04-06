class Micropost < ApplicationRecord
  belongs_to :user
  # 使用 default_scope 排序微博
  default_scope -> { order(created_at: :desc) }
  # 验证微博的 user_id 是否存在
  validates :user_id, presence: true
  # Micropost 模型的验证
  validates :content, presence: true, length: { maximum: 140 }
end
