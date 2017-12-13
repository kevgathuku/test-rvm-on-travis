# encoding: UTF-8
require "bacon"

RSpec.describe Bacon do
  it "is edible" do
    expect(Bacon).to be_edible
  end
end
