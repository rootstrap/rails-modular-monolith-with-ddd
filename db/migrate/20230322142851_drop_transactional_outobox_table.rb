class DropTransactionalOutoboxTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :transactional_outbox_outboxes
  end
end
