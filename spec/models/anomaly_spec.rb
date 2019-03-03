require 'rails_helper'

RSpec.describe Anomaly, type: :model do
  it { should validate_presence_of(:day) }
  it { should belong_to(:employee) }
end
