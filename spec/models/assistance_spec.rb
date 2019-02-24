require 'rails_helper'

RSpec.describe Assistance, type: :model do
  it { should validate_presence_of(:entry) }
  it { should validate_presence_of(:exit) }
  it { should belong_to(:employee) }
end
