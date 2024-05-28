# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe "validations" do
#     let(:user) {create(:user)}

#     context "Normal scenario" do
#       it "必要なパラメータが入力されている場合、登録できること" do
#         user = build(:user)
#         expect(user).to be_valid
#       end
#     end

#     context "Abnormal scenario" do
#       it "nameカラムが空欄の場合、登録できないこと" do
#         user.name = ''
#         expect(user).to be_invalid
#       end

#       it "emailカラムが空欄の場合、登録できないこと" do
#         user.email = ''
#         expect(user).to be_invalid
#       end

#       it "メールアドレスのフォーマットでない場合、登録できないこと" do
#         user.email = 'example'
#         expect(user).to be_invalid
#       end

#       it "passwordカラムが空欄の場合、登録できないこと" do
#         user.password = ''
#         expect(user).to be_invalid
#       end

#       it 'passwordとpassword_confirmationが一致しない場合、登録できないこと' do
#         user.password = 'aaaaa'
#         user.password_confirmation = 'bbbbb'
#         expect(user).to be_invalid
#       end
#     end
#   end
# end
