require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
    end

    context 'nicknameカラム' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'postal_codeカラム' do
      it '空欄でないこと' do
        user.postal_code = ''
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        user.address = ''
        is_expected.to eq false
      end
    end

  end

end