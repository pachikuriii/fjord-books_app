# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
    @user = users(:alice)
    visit root_url
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test '日報のトップページへ移動する時' do
    visit reports_url
    assert_selector 'h1', text: '日報', match: :prefer_exact
  end

  test '日報を新規作成する時' do
    visit reports_url
    click_on '新規作成'
    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_selector 'p', text: @report.title, match: :prefer_exact
    assert_selector 'p', text: @report.content, match: :prefer_exact
  end

  test '日報を編集する時' do
    visit reports_url
    click_on '編集', match: :prefer_exact
    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test '日報を削除する時' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :prefer_exact
    end
    assert_text '日報が削除されました。'
  end
end
