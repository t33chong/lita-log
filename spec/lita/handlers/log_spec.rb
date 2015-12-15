require 'spec_helper'

describe Lita::Handlers::Log, lita_handler: true do
  let(:alice) { Lita::User.create('U1', name: 'Alice', mention_name: 'alice') }
  let(:bob) { Lita::User.create('U2', name: 'Bob', mention_name: 'bob') }
  let(:logger) { double('Logger') }

  before do
    robot.auth.add_user_to_group!(alice, :log_admins)
    allow_any_instance_of(described_class).to receive(:log).and_return(logger)
  end

  it { is_expected.not_to route_command('log info foo bar').to(:log_message) }
  it { is_expected.not_to route_command('log foo bar baz').to(:log_message) }
  it { is_expected.to route_command('log info foo bar').with_authorization_for(:log_admins).to(:log_message) }
  it { is_expected.to route_command('LOG foo bar baz').with_authorization_for(:log_admins).to(:log_message) }

  describe '#log_message' do
    context 'when the user is authorized' do
      it 'logs a message with a valid level' do
        expect(logger).to receive(:info).with('foo bar baz')
        send_command('log Info foo bar baz', as: alice)
        expect(replies.count).to eq(1)
        expect(replies.last).to eq("Successfully logged 'foo bar baz' with level INFO")
      end

      it 'complains with an invalid level' do
        expect(logger).not_to receive(:foo)
        send_command('log foo bar baz', as: alice)
        expect(replies.count).to eq(1)
        expect(replies.last).to eq('foo is not a valid log level. Try: UNKNOWN, FATAL, ERROR, WARN, INFO, DEBUG')
      end
    end

    context 'when the user is not authorized' do
      it 'does nothing' do
        expect(logger).not_to receive(:info)
        send_command('log info foo bar baz', as: bob)
        expect(replies.count).to eq(0)
      end
    end
  end
end
