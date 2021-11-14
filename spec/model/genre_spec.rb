require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    # let(:user) { create(:user) }
    let!(:genre) { build(:genre) }
    # let(:item) { create(:item, item_user_id: user.id, genre_id: genre.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
    end

  end
end