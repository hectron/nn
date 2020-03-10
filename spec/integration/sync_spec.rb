RSpec.describe "`nn sync` command", type: :cli do
  it "executes `nn help sync` command successfully" do
    output = `nn help sync`
    expected_output = <<-OUT
Usage:
  nn sync

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
