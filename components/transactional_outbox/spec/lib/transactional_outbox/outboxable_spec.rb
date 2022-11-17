# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionalOutbox::Outboxable do
  let(:dummy_model) do
    Class.new(ApplicationRecord) do
      include TransactionalOutbox::Outboxable
    end
  end

  before do
    stub_const('Model', dummy_model)
  end

  describe '#save' do
    let(:model) { instance_double(Model, save: true) }

    subject { model.save }

    context 'when record is created' do
      context 'when outbox record is created' do
        # TODO: Do we want to check if the record is actually saved in the database?
        # This expectation is just checking the stubbed value
        it { is_expected.to be true }

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end
      end

      context 'when there is an error when creating the outbox record' do
        before do
          # outbox save returns false/is invalid.
        end

        it 'does not create the record' do

        end

        it 'does not create the outbox record' do
          expect { subject }.not_to change(TransactionalOutbox::Outbox, :count).by(1)
        end
      end
    end

    context 'when the record could not be created' do
      it 'does not create the record' do

      end

      it 'does not create the outbox record' do
        expect { subject }.not_to change(TransactionalOutbox::Outbox, :count).by(1)
      end
    end
  end
end
