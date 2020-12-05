require_relative "../lib/basic"
require 'spec_helper'
require 'benchmark'

RSpec.describe Basic do
  it "it doing good under the stress" do
    puts Benchmark.measure {
      1000.times do
        Basic.cd_into("lib")
      end
    }
  end
end
