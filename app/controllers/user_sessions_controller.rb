class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      # redirect_back_or_to shops_path, success: t('.success')
      redirect_to root_path, success: '会員登録に成功しました' # 仮の処理。ショップ一覧ページができたら↑に替える
    else
      flash.now[:error] = '会員登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end
end
