class CategoriesController < ApplicationController
  def new
    @title = "Create a new category"
    @category = Category.new
    @action = :create
  end

  def create
    @category = Category.new(category_params[:category])
    if @category.save
      redirect_to category_path(@category)
    else
      render "new"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.permit(category:[:id, :name, :image, :photo_url])
  end

end
