class MoosController < ApplicationController
  def index
    @moo = Moo.all
  end

  def show
  end

  def new
    @moo = current_user.moos.new
  end

  def create
    @moo = current_user.moos.new(moo_params)

    if @moo.save
      redirect_to @moo, notice: 'Your moo was created!'
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
