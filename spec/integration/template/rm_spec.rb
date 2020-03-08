RSpec.describe "`nn template rm` command", type: :cli do
  it "executes `nn template help rm` command successfully" do
    output = `nn template help rm`
    expected_output = <<-OUT
Usage:
  nn rm TEMPLATE

Options:
  -h, [--help], [--no-help]  # Display usage information

Delete a template
    OUT

    expect(output).to eq(expected_output)
  end
end
