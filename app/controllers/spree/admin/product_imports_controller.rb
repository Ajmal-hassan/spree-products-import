class Spree::Admin::ProductImportsController < Spree::Admin::BaseController

  def index
    @product_import = Spree::ProductImport.new
  end

  def create
    @product_import = Spree::ProductImport.new(product_import_params[:product_import])
    if @product_import.save
      redirect_to admin_url, notice: "Import process started successfully"
    else
      render :index
    end
  end

  private
    def product_import_params
      params.permit(product_import: [:csv_file])
    end


end
