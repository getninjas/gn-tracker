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
        '@timestamp' => now,
        '@version' => '1'
      )
    end
  end
end
