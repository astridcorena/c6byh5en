class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session

  def index
   @products = Product.all
   render :json => @products
 end

 def new
   @product = Product.new
 end

 def create
   @product = Product.create(product_params)
   if @product.save
     render json: @product, status: 201
   else
     render json: {errors: @product.errors}, status: 422
   end
 end

 def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
    # if @product.save
      render json: @product, :status => 200
    else
      render json: @product.errors.full_messages, :status => 422
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    {:status => 204}
  end

 private
  def product_params
    params.require(:product).permit(:name, :price)
  end

end
