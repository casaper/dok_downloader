class TargetDirsController < ApplicationController
  before_action :set_target_dir, only: %i[show edit update destroy]

  def index
    @target_dirs = TargetDir.all
  end

  def show; end

  def new
    @target_dir = TargetDir.new
  end

  def edit; end

  def create
    @target_dir = TargetDir.new(target_dir_params)

    if @target_dir.save
      redirect_to @target_dir, notice: 'Target dir was successfully created.'
    else
      render :new
    end
  end

  def update
    if @target_dir.update(target_dir_params)
      redirect_to @target_dir, notice: 'Target dir was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @target_dir.destroy
    redirect_to target_dirs_url, notice: 'Target dir was successfully destroyed.'
  end

  private

  def set_target_dir
    @target_dir = TargetDir.find(params[:id])
  end

  def target_dir_params
    params.require(:target_dir).permit(:path, :name)
  end
end
