require 'rails_helper'

RSpec.describe WorkDay, type: :model do
  it { should belong_to(:employee) }
  it { should validate_presence_of(:total_hours) }
  it { should validate_presence_of(:day) }
end
