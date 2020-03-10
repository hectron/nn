RSpec.describe "`nn new` command", type: :cli do
  it "executes `nn help new` command successfully" do
    output = `nn help new`
    expected_output = <<-OUT
Usage:
  nn new NOTE

Options:
  -h, [--help], [--no-help]  # Display usage information

Create a new note
    OUT

    expect(output).to eq(expected_output)
  end
end
