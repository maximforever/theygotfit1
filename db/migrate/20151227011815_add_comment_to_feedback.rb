class AddCommentToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :comment, :text
    remove_column :feedbacks, :feedback
    remove_column :feedbacks, :suggestion
  end
end
