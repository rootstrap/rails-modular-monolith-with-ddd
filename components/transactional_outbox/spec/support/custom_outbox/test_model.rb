module CustomOutbox
  class TestModel < CustomOutbox::ApplicationRecord
    include TransactionalOutbox::Outboxable
    validates :identifier, presence: true
  end
end
