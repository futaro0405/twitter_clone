# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'ツイート:POST posts#create' do
    context '正常系：パラメータ正常のとき' do
      let(:user) { create(:user) }
      let(:post_params) { { content: 'テスト投稿' } }

      before do
        user.confirm
        sign_in user
      end

      it 'requestが成功すること' do
        post posts_path, params: { post: post_params }, headers: { HTTP_REFERER: root_url }
        expect(response).to have_http_status(:see_other)
      end

      it 'ツイートcreateに成功すること' do
        expect do
          post posts_path, params: { post: post_params }, headers: { HTTP_REFERER: root_url }
        end.to change(user.posts, :count).by 1
      end

      it 'root_pathにリダイレクトされること' do
        post posts_path, params: { post: post_params }, headers: { HTTP_REFERER: root_url }
        expect(response).to redirect_to root_url
      end
    end

    context '異常系：パラメータ不正のとき' do
      let(:user) { create(:user) }
      let(:post_params) { { content: '' } }

      before do
        user.confirm
        sign_in user
      end

      it 'requestが成功すること' do
        post posts_path, params: { post: post_params }
        expect(response).to have_http_status(:see_other)
      end

      it 'ツイートcreateに失敗すること' do
        expect do
          post posts_path, params: { post: post_params }
        end.not_to change(user.posts, :count)
      end
    end
  end
end
