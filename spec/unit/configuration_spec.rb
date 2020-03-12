require 'nn/configuration'

RSpec.describe Nn::Configuration do

  describe '.current_config' do
    it 'returns the available config' do
      expect(described_class.current_config).to include(*Nn::Configuration::SETTINGS_AVAILABLE)
    end
  end

  describe 'accessor methods' do
    let(:mock_config) { {} }
    let(:mock_instance) { described_class.new }

    before do
      allow(described_class).to receive(:instance).and_return(mock_instance)
      allow(mock_instance).to receive(:current_config).and_return(mock_config)
    end

    describe '.note_directory' do
      let(:mock_config) { { note_directory: '~/e/takes/notes' } }
      let(:directory) { File.expand_path('~/e/takes/notes') }

      subject { described_class.note_directory }

      it { is_expected.to eq(directory) }
    end

    describe '.prefix' do
      let(:mock_config) { { prefix: '%Y%m' } }

      subject { described_class.prefix }

      it { is_expected.to eq('%Y%m') }
    end

    describe '.template' do
      let(:mock_config) { { template: 'meeting' } }

      subject { described_class.template }

      it { is_expected.to eq('meeting') }
    end

    describe '.filetype' do
      let(:mock_config) { { filetype: '.json' } }

      subject { described_class.filetype }

      it { is_expected.to eq('.json') }
    end
  end

  describe 'environment variables' do
    let(:mock_instance) { described_class.new }

    before do
      # Monkey patch the environment before we load the config
      allow(ENV).to receive(:has_key?).with('NN_FILETYPE').and_return(true)
      allow(ENV).to receive(:has_key?).with('NN_NOTE_DIRECTORY').and_return(true)
      allow(ENV).to receive(:has_key?).with('NN_TEMPLATE').and_return(true)
      allow(ENV).to receive(:has_key?).with('NN_PREFIX').and_return(true)

      allow(ENV).to receive(:[]).with("NN_FILETYPE").and_return(".py")
      allow(ENV).to receive(:[]).with("NN_NOTE_DIRECTORY").and_return("/etc")
      allow(ENV).to receive(:[]).with("NN_TEMPLATE").and_return("1-1")
      allow(ENV).to receive(:[]).with("NN_PREFIX").and_return("%Z")

      # When we call current_config, this will generate a new config
      allow(described_class).to receive(:instance).and_return(mock_instance)
    end

    context '.note_directory' do
      subject { described_class.note_directory }
      it { is_expected.to eq('/etc') }
    end

    context '.prefix' do
      subject { described_class.prefix }
      it { is_expected.to eq('%Z') }
    end

    context '.template' do
      subject { described_class.template }
      it { is_expected.to eq('1-1') }
    end

    context '.filetype' do
      subject { described_class.filetype }
      it { is_expected.to eq('.py') }
    end
  end
end
