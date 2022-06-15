# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    # サインアップ時にストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name postcode address introduction])
    # アカウント編集の時にストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name postcode address introduction])
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    books_path
  end
end
