# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionalOutbox::Outboxable do
  let!(:FakeModel) do
    FakeModel = Class.new(ApplicationRecord) do
      include TransactionalOutbox::Outboxable
    end
  end

  before do
    ActiveRecord::Base.connection.create_table :fake_models do |t|
      t.uuid :identifier, null: false
    end
  end

  describe '#save' do
    subject { FakeModel.new(identifier: identifier).save }

    context 'when record is created' do
      let(:identifier) { SecureRandom.uuid }

      context 'when outbox record is created' do
        it { is_expected.to be true }

        it 'creates the record' do
          expect { subject }.to change(FakeModel, :count).by(1)
        end

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end
      end

      context 'when there is an error when creating the outbox record' do
        before do
          expect(TransactionalOutbox::Outbox).to receive(:create!).and_raise
        end

        it { is_expected.to be false }

        it 'does not create the record' do
          expect { subject }.to raise_error.and not_to change(FakeModel, :count)
        end

        it 'does not create the outbox record' do
          expect { subject }.to raise_error.and not_to change(TransactionalOutbox::Outbox, :count)
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
