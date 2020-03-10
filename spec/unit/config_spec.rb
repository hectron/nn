require 'nn/commands/config'

RSpec.describe Nn::Commands::Config do
  it "executes `config` command successfully" do
    output = StringIO.new
    options = {}
    command = Nn::Commands::Config.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
