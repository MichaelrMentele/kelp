require 'rails_helper'

describe Business do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:blurb) }
  it { should validate_presence_of(:img_url) }
  it { should validate_presence_of(:synopsis) }
  it { should validate_presence_of(:location) }
  it { is_expected.to have_many(:reviews).order('position DESC') }
end