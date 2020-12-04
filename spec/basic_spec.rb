require_relative "../lib/basic"
require 'spec_helper'

RSpec.describe Basic do
  it "can cd into an existing path" do
    expect{Basic.cd_into("lib")}.to output("all fine\n").to_stdout
  end
  it "can cd into an unexistent path" do
    expect{Basic.cd_into("kk")}.to output("everything is still fine\n").to_stdout
  end
end
