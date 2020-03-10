require 'nn/commands/template/ls'

RSpec.describe Nn::Commands::Template::Ls do
  it "executes `template ls` command successfully" do
    output = StringIO.new
    options = {}
    command = Nn::Commands::Template::Ls.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
