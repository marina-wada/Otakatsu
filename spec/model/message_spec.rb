require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
  subject { message.valid? }

    let(:user) { create(:user) }
    let!(:message) { build(:message, user_id: user.id) }

    context 'messageカラム' do
      it '空欄でないこと' do
        message.message = ''
        is_expected.to eq false
      end
    end

  end
end