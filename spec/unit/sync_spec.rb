require 'nn/commands/sync'

RSpec.describe Nn::Commands::Sync do
  it "executes `sync` command successfully" do
    output = StringIO.new
    options = {}
    command = Nn::Commands::Sync.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
