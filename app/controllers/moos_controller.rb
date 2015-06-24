class MoosController < ApplicationController
  before_action :set_moo, only: [:edit, :update, :destroy]

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    if current_user
      @moos = Moo.timeline(current_user).page(params[:page]).per(5)
    else
      @moos = Moo.all
    end
  end

  def show
  end

  def new
    @moo = current_user.moos.new
  end

  def create
    @moo = current_user.moos.create(moo_params)

    if @moo.save
      redirect_to moos_path, notice: 'Your moo was created!'
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @moo.destroy
    redirect_to moos_url, notice: 'Your moo was deleted!'
  end

  private

  def set_moo
    @moo = current_user.moos.find(params[:id])
  end

  def moo_params
    params.require(:moo).permit(:user_id, :description)
  end
end
