class OutboxService
  def create!(event:)
    ActiveRecord::Base.transaction do
      created_record = yield

      outbox_class.create!(
        event: event,
        aggregate_identifier: created_record.identifier,
        aggregate: created_record.class.name,
        payload: created_record.as_json
      )
    end
  end

  private

  def outbox_class; end
end
