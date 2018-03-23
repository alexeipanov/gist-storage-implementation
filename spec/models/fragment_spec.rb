require 'rails_helper'

RSpec.describe Fragment, type: :model do
  it 'is valid with valid attributes' do
      fragment = Fragment.create({ value: 'test', private: false })
      expect(fragment).to be_valid
  end

  it 'is invalid with empty value' do
    fragment = Fragment.create({ value: nil, private: nil })
    expect(fragment).to_not be_valid
  end

  it 'is invalid with overflow value' do
    fragment = Fragment.create({ value: 'a' * 8193, private: true })
    expect(fragment).to_not be_valid
  end

  it 'is valid with valid preview value' do
      fragment = Fragment.create({ value: 'test ' * 6, private: false })
      expect(fragment.preview_value).to eq('test test test test test...')
  end
end
