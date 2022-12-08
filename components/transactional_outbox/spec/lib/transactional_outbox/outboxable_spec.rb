# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionalOutbox::Outboxable do
  FakeModel = Class.new(ApplicationRecord) do
    include TransactionalOutbox::Outboxable
    validates :identifier, presence: true
  end

  before do
    ActiveRecord::Base.connection.create_table :fake_models do |t|
      t.uuid :identifier, null: false
    end
  end

  describe '#save' do
    subject { FakeModel.new(identifier: identifier).save }

    let(:identifier) { SecureRandom.uuid }

    context 'when record is created' do
      context 'when outbox record is created' do
        it { is_expected.to be true }

        it 'creates the record' do
          expect { subject }.to change(FakeModel, :count).by(1)
        end

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end

        it 'creates the outbox record with the correct data' do
          subject
          outbox = TransactionalOutbox::Outbox.last
          expect(outbox.aggregate).to eq('FakeModel')
          expect(outbox.aggregate_identifier).to eq(identifier)
          expect(outbox.event).to eq('CREATE_FakeModel')
          expect(outbox.identifier).not_to be_nil
          expect(outbox.payload.to_json).to eq(FakeModel.last.to_json)
        end
      end

      context 'when there is a record invalid error when creating the outbox record' do
        before do
          allow(TransactionalOutbox::Outbox).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        end

        it { is_expected.to be false }

        it 'does not create the record' do
          expect { subject }.not_to change(FakeModel, :count)
        end

        it 'does not create the outbox record' do
          expect { subject }.not_to change(TransactionalOutbox::Outbox, :count)
        end
      end

      context 'when there is an error when creating the outbox record' do
        before do
          allow(TransactionalOutbox::Outbox).to receive(:create!).and_raise(ActiveRecord::RecordNotSaved)
        end

        it 'raises error' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved)
        end

        it 'does not create the record' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved).and not_change(FakeModel, :count)
        end

        it 'does not create the outbox record' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved).and not_change(TransactionalOutbox::Outbox, :count)
        end
      end
    end

    context 'when the record could not be created' do
      let(:identifier) { nil }

      it { is_expected.to be false }

      it 'does not create the record' do
        expect { subject }.not_to change(FakeModel, :count)
      end

      it 'does not create the outbox record' do
        expect { subject }.not_to change(TransactionalOutbox::Outbox, :count)
      end
    end
  end

  describe '#save!' do
    subject { FakeModel.new(identifier: identifier).save! }

    let(:identifier) { SecureRandom.uuid }

    context 'when record is created' do
      context 'when outbox record is created' do
        it { is_expected.to be true }

        it 'creates the record' do
          expect { subject }.to change(FakeModel, :count).by(1)
        end

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end
      end

      context 'when there is a record invalid error when creating the outbox record' do
        before do
          allow(TransactionalOutbox::Outbox).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        end

        it 'raises error' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'does not create the record' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid).and not_change(FakeModel, :count)
        end

        it 'does not create the outbox record' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid).and not_change(TransactionalOutbox::Outbox, :count)
        end
      end

      context 'when there is an error when creating the outbox record' do
        before do
          allow(TransactionalOutbox::Outbox).to receive(:create!).and_raise(ActiveRecord::RecordNotSaved)
        end

        it 'raises error' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved)
        end

        it 'does not create the record' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved).and not_change(FakeModel, :count)
        end

        it 'does not create the outbox record' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved).and not_change(TransactionalOutbox::Outbox, :count)
        end
      end
    end

    context 'when the record could not be created' do
      let(:identifier) { nil }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'does not create the record' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid).and not_change(FakeModel, :count)
      end

      it 'does not create the outbox record' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid).and not_change(TransactionalOutbox::Outbox, :count)
      end
    end
  end
end
