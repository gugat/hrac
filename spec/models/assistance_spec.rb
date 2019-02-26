require 'rails_helper'

RSpec.describe Assistance, type: :model do
  it { should validate_presence_of(:happening_at) }
  it { should validate_presence_of(:kind) }
  it { should belong_to(:employee) }
end
