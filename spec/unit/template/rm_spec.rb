require 'nn/commands/template/rm'

RSpec.describe Nn::Commands::Template::Rm do
  it "executes `template rm` command successfully" do
    output = StringIO.new
    template = nil
    options = {}
    command = Nn::Commands::Template::Rm.new(template, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
