class ArteDownloadsController < ApplicationController
  before_action :set_arte_download, only: %i[show edit update destroy]

  def index
    @arte_downloads = ArteDownload.all
  end

  def show; end

  def new
    @arte_download = ArteDownload.new
  end

  def edit; end

  def create
    @arte_download = ArteDownload.new(arte_download_params)
    @arte_download.user = current_user

    if @arte_download.save
      redirect_to @arte_download, notice: 'Arte download was successfully created.'
    else
      render :new
    end
  end

  def update
    if @arte_download.update(arte_download_params)
      redirect_to @arte_download, notice: 'Arte download was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @arte_download.destroy
    redirect_to arte_downloads_url, notice: 'Arte download was successfully destroyed.'
  end

  private

  def set_arte_download
    @arte_download = ArteDownload.find(params[:id])
  end

  def arte_download_params
    params.require(:arte_download).permit(:target_dir_id, :url, :added_at, :title, :description)
  end
end
