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
          expect(outbox.payload['after'].to_json).to eq(FakeModel.last.to_json)
          expect(outbox.payload['before']).to be_nil
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

  describe '#create' do
    subject { FakeModel.create(identifier: identifier) }

    let(:identifier) { SecureRandom.uuid }

    context 'when record is created' do
      context 'when outbox record is created' do
        it { is_expected.to eq(FakeModel.last) }

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
          expect(outbox.payload['after'].to_json).to eq(FakeModel.last.to_json)
          expect(outbox.payload['before']).to be_nil
        end
      end
    end
  end

  describe '#update' do
    subject { fake_model.update(identifier: new_identifier) }

    let!(:fake_model) { FakeModel.create(identifier: identifier) }
    let!(:fake_old_model) { fake_model.to_json }
    let(:identifier) { SecureRandom.uuid }
    let(:new_identifier) { SecureRandom.uuid }

    context 'when record is updated' do
      context 'when outbox record is created' do
        it { is_expected.to be true }

        it 'updates the record' do
          expect { subject }.to not_change(FakeModel, :count)
            .and change(fake_model, :identifier).to(new_identifier)
        end

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end

        it 'creates the outbox record with the correct data' do
          subject
          outbox = TransactionalOutbox::Outbox.last
          expect(outbox.aggregate).to eq('FakeModel')
          expect(outbox.aggregate_identifier).to eq(new_identifier)
          expect(outbox.event).to eq('UPDATE_FakeModel')
          expect(outbox.identifier).not_to be_nil
          expect(outbox.payload['before'].to_json).to eq(fake_old_model)
          expect(outbox.payload['after'].to_json).to eq(fake_model.reload.to_json)
        end
      end
    end
  end

  describe '#destroy' do
    subject { fake_model.destroy }

    let!(:fake_model) { FakeModel.create(identifier: identifier) }
    let(:identifier) { SecureRandom.uuid }

    context 'when record is destroyed' do
      context 'when outbox record is created' do
        it { is_expected.to eq(fake_model) }

        it 'destroys the record' do
          expect { subject }.to change(FakeModel, :count).by(-1)
        end

        it 'creates the outbox record' do
          expect { subject }.to change(TransactionalOutbox::Outbox, :count).by(1)
        end

        it 'creates the outbox record with the correct data' do
          subject
          outbox = TransactionalOutbox::Outbox.last
          expect(outbox.aggregate).to eq('FakeModel')
          expect(outbox.aggregate_identifier).to eq(identifier)
          expect(outbox.event).to eq('DESTROY_FakeModel')
          expect(outbox.identifier).not_to be_nil
          expect(outbox.payload['after']).to be_nil
          expect(outbox.payload['before'].to_json).to eq(fake_model.to_json)
        end
      end
    end
  end
end