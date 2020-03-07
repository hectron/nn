RSpec.describe "`nn template` command", type: :cli do
  it "executes `nn help template` command successfully" do
    output = `nn help template`
    expected_output = <<-OUT
Usage:
  nn template

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
