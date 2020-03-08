require 'nn/commands/new_note'

RSpec.describe Nn::Commands::NewNote do
  it "executes `new` command successfully" do
    output = StringIO.new
    note = nil
    options = {}
    command = Nn::Commands::NewNote.new(note, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
