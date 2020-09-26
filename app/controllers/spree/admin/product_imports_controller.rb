class Spree::Admin::ProductImportsController < Spree::Admin::BaseController

  def index
    @product_import = Spree::ProductImport.new
  end

  def create
    @product_import = Spree::ProductImport.new(product_import_params[:product_import])
    directory_name = "public/uploads"
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    begin
      File.delete(Rails.root.join('public', 'uploads/sample.csv'))
    rescue
    end
    uploaded_io = product_import_params[:product_import]
    uploaded_io['csv_file'].original_filename = 'sample.csv'
    File.open(Rails.root.join('public', 'uploads', uploaded_io['csv_file'].original_filename), 'wb') do |file|
      file.write(uploaded_io['csv_file'].read)
    end
    @product_import.start_product_import
    redirect_to spree.admin_products_url, notice: "Import process started successfully"

  end

  private
  def product_import_params
    params.permit(product_import: [:csv_file])
  end


end