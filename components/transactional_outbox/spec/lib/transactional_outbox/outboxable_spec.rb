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
      t.uuid :identifier
      t.string :foo
    end
  end

  describe '#save' do
    subject { FakeModel.new(identifier: SecureRandom.uuid, foo: foo).save }

    context 'when record is created' do
      context 'when outbox record is created' do
        let(:foo) { :bar }

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
