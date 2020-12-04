require_relative "../lib/basic"
require 'spec_helper'

RSpec.describe Basic do
  it "can output" do
    expect{Basic.cd_into}.to output("ok\n").to_stdout 
  end
end
