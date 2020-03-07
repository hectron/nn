require 'nn/commands/template'

RSpec.describe Nn::Commands::Template do
  it "executes `template` command successfully" do
    output = StringIO.new
    options = {}
    command = Nn::Commands::Template.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
