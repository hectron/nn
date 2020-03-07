RSpec.describe "`nn config` command", type: :cli do
  it "executes `nn help config` command successfully" do
    output = `nn help config`
    expected_output = <<-OUT
Usage:
  nn config

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
