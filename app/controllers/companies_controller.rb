class CompaniesController < ApplicationController
  before_action :get_company, only: [:show, :upload_pic]

  def new
    @company = current_user.companies.build
  end

  def upload_pic
    if @company.update_attributes(company_pic_attrs)
      flash[:success] = "Updated pic successfully"
    else
      flash[:error] = "Failed to update pic"
    end
    redirect_to company_path(@company)    
  end

  def create
    company = current_user.companies.build(company_attrs)
    if company.save
      flash[:success] = 'Company Created successfully'
      set_current_entity(company)
      redirect_to company_path(company)
    else
      render_with_error(company.errors.full_messages.join(','), 422)
    end
  end

  def show
    set_current_entity(@company)
  end

  private

  def company_attrs
    params.require(:company).permit(:phone, :email, :website, :location,
      admin_user_ids: [],
      profile_attributes: [:name, :about, :avatar, :cover_pic],
      photos_attributes: [:id, :file, :_destroy],
      address_attributes: [:address],
      categories_attributes: [:make, :model]
    )
  end

  def company_pic_attrs
    params.require(:company).permit(
      profile_attributes: [:avatar, :cover_pic]
    )
  end

  def get_company
    @company ||= Company.find(params[:id])
  end
end
