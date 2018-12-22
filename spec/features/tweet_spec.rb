require 'rails_helper'

feature 'tweet', type: :feature do
  let(:user) { create(:user)}

  scenario 'post tweet' do
#ログイン前は投稿ボタンがないことの確認
    visit root_path
    expect(page).to have_no_content('投稿する')

# ログイン処理の確認
    visit new_user_session_path
    fill_in 'user_email', with: user.user_email
    fill_in 'user_password', with: user.user_password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    expect(page).to have_content('投稿する')

#ツイート投稿の確認
    expect {
      click_link('投稿する')
      expect(current_path).to eq new_tweet_path
      fill_in 'image', with: 'http://s.eximg.jp/expub/feed/Papimami/2016/Papimami_83279/Papimami_83279_1.png'
      fill_in 'text', with: 'フィーチャスペックのテスト'
      find('input[tyoe="submit"]').click
    }.to change(Tweet, :count).by(1)
  end
end
