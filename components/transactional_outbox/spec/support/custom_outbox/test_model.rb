module CustomOutbox
  class TestModel < ApplicationRecord
    include TransactionalOutbox::Outboxable
    validates :identifier, presence: true
  end
end
