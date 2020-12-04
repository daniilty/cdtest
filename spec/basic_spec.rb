require_relative "../lib/basic"
require 'spec_helper'

RSpec.describe Basic do
  context "is being tested in units" do
    it "when cd into an existing path" do
      expect{Basic.cd_into("lib")}.to output("all fine\n").to_stdout
    end
    it "when cd into an unexistent path" do
      expect{Basic.cd_into("kk")}.to raise_error
    end
    it "when cd into an unexistent path and making a new one" do 
      expect{Basic.make_dir_and_cd("kk")}.to output("everything is still fine\n").to_stdout
    end
  end
end
