require 'spec_helper'
require 'gn/tracker'

describe Gn::Tracker, '#track_unstruct_event' do
  let(:message) { { answer: 42 } }
  let(:schema) { 'iglu:br.com.getninjas.com.br/schema/1.0.0' }
  let(:application) { 'App' }
  let(:now) { Time.new(2017, 10, 30) }

  before do
    allow(Time).to receive(:now).and_return now

    allow(LogStash::Event).to receive(:new).and_call_original
  end

  context 'true_timestamp' do
    context 'passing the true_timestamp argument' do
      let(:true_timestamp) { '1483315200001' }

      it 'uses this argument to generate the log line' do
        subject.track_unstruct_event(
          message: message,
          schema: schema,
          application: application,
          true_timestamp: true_timestamp
        )

        expect(LogStash::Event).to have_received(:new).with(
          message: message.to_json,
          schema: schema,
          application: application,
          true_timestamp: true_timestamp,
          context: "[]",
          '@timestamp' => now,
          '@version' => '1'
        )
      end
    end

    context 'not passing true_timestamp argument' do
      before do
        allow(DateTime).to receive(:now).and_return DateTime.new(2017, 1, 2)
      end

      it 'generates a default one to generate the log line' do
        subject.track_unstruct_event(
          message: message,
          schema: schema,
          application: application
        )

        expect(LogStash::Event).to have_received(:new).with(
          message: message.to_json,
          schema: schema,
          application: application,
          true_timestamp: '1483315200000',
          context: "[]",
          '@timestamp' => now,
          '@version' => '1'
        )
      end
    end
  end

  context 'context argument' do
    before do
      allow(DateTime).to receive(:now).and_return DateTime.new(2017, 1, 2)
    end

    context 'passing the context argument' do
      let(:message_context) { { is_answer_meaningless: "yes" } }
      let(:schema_context) { 'iglu:br.com.getninjas.com.br/schema_context/1.0.0' }

      let(:context) do
        [
          {
            schema: schema_context,
            message: message_context
          }
        ]
      end

      it 'uses the argument to generate the log line' do
        subject.track_unstruct_event(
          message: message,
          schema: schema,
          application: application,
          context: context
        )

        expect(LogStash::Event).to have_received(:new).with(
          message: message.to_json,
          schema: schema,
          application: application,
          true_timestamp: '1483315200000',
          context: context.to_json,
          '@timestamp' => now,
          '@version' => '1'
        )
      end
    end

    context 'not passing the true_timestamp argument' do
      it 'uses a empty array to generate the log line' do
        subject.track_unstruct_event(
          message: message,
          schema: schema,
          application: application
        )

        expect(LogStash::Event).to have_received(:new).with(
          message: message.to_json,
          schema: schema,
          application: application,
          true_timestamp: '1483315200000',
          context: "[]",
          '@timestamp' => now,
          '@version' => '1'
        )
      end
    end
  end
end
