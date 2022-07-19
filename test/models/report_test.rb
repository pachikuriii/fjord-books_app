# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable? 投稿者が編集する時' do
    current_user = users(:alice)
    assert reports(:one).editable?(current_user)
  end

  test '#editable? 投稿者以外が編集する時' do
    current_user = users(:carol)
    assert_not reports(:one).editable?(current_user)
  end

  test '#created_on 作成日時をdateにする時' do
    assert_equal reports(:one).created_on, reports(:one).created_at.to_date
  end
end
