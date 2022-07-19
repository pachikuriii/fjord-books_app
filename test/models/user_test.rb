# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
  end

  test '#following? フォローしている時' do
    assert_not @alice.following?(@bob)
    Relationship.create!(following_id: @bob.id, follower_id: @alice.id)
    assert @alice.following?(@bob)
  end

  test '#followed_by? フォローされている時' do
    assert_not @bob.followed_by?(@alice)
    Relationship.create!(following_id: @bob.id, follower_id: @alice.id)
    assert @bob.followed_by?(@alice)
  end

  test '#follow フォローする時' do
    assert_not Relationship.find_by(following_id: @bob.id, follower_id: @alice.id)
    @alice.follow(@bob)
    assert Relationship.find_by(following_id: @bob.id, follower_id: @alice.id)
  end

  test '#unfollow フォロー解除する時' do
    assert_not Relationship.find_by(following_id: @bob.id, follower_id: @alice.id)
    Relationship.create!(following_id: @bob.id, follower_id: @alice.id)
    assert Relationship.find_by(following_id: @bob.id, follower_id: @alice.id)
    @alice.unfollow(@bob)
    assert_not Relationship.find_by(following_id: @bob.id, follower_id: @alice.id)
  end

  test '#name_or_email ユーザ情報に名前がない場合にメールアドレスを表示する時' do
    @carol.name = ''
    assert_empty @carol.name
    assert_equal @carol.email, @carol.name_or_email

    assert_not_empty @bob.name
    assert_not_equal @bob.email, @bob.name_or_email
  end
end
