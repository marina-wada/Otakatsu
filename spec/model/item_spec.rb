require 'rails_helper'

RSpec.describe 'Itemモデルのテスト', type: :model do
  describe 'バリデーションのチェック' do
    subject { item.valid? }

    let(:user) { create(:user) }
    let(:genre) { create(:genre) }
    let!(:item) { build(:item, item_user_id: user.id, genre_id: genre.id) }


    context 'item_imageカラム' do
      it '空欄でないこと' do
        item.item_image = ''
        is_expected.to eq false
      end
    end

    context 'characterカラム' do
      it '空欄でないこと' do
        item.character = ''
        is_expected.to eq false
      end
    end

    context 'ask_item1カラム' do
      it '空欄でないこと' do
        item.ask_item1 = ''
        is_expected.to eq false
      end
    end

  end
end