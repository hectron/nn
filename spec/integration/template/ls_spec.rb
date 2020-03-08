RSpec.describe "`nn template ls` command", type: :cli do
  it "executes `nn template help ls` command successfully" do
    output = `nn template help ls`
    expected_output = <<-OUT
Usage:
  nn ls

Options:
  -h, [--help], [--no-help]  # Display usage information

List templates available
    OUT

    expect(output).to eq(expected_output)
  end
end
