class OrgProductsController < ApplicationController
  before_action :signed_in_user, :user_has_role_in_company?, only: [:index, :new, :create, :edit, :update, :delete, :orders, :completed_orders]
  before_action  :registered_company, only: [:index, :new, :create, :edit, :update, :delete]

  def index
    @contact = OrgContact.find_by(org_person_id: current_org_person.id)
    @country = TypCountry.find_by_id(@contact['typ_country_id'])
    @currency = Money.new(1, @country["currency_code"]).currency
    if current_org_person.org_company_id
      @org_products = OrgProduct.paginate(page: params[:page]).where(org_company_id: current_org_person.org_company_id)
    end
  end

  def show
  end

  def new
    signed_in_user #Only signed in users can post
    @tax_details = get_tax_details #Get the tax details option for this post based on company location
    if current_org_person
      registered_company #Make sure they are associated with a company
      @product = OrgProduct.new #makes a new product object
    end
  end

  def create
    # Grab the contact inform for the company
    @tax_details = get_tax_details
    @companyContact = OrgContact.find_by(org_company_id: current_org_person.org_company_id, org_person_id: nil)
    @productInfo = product_params_sanitizer(product_params) # Use sanitizer to return a sanitized hash
    @productInfo[:org_company_id] = @companyContact["org_company_id"] # Add the org_company_id in the hash
    @productInfo[:latitude] = @companyContact["latitude"]
    @productInfo[:longitude] = @companyContact["longitude"]
    @product = OrgProduct.create(@productInfo)

    if @product.update_attributes(@productInfo) # If we save properly
      flash[:success] = "Thank you. Your product = "+@productInfo['name']+" - has been posted"
      redirect_to edit_org_product_path(@product.id) # Redirect us to the product edit path
    else
      render :new
    end

  end

  def edit
    signed_in_user # Only signed in users can edit post
    @tax_details = get_tax_details # Get the tax options for this post based on company location
    if current_org_person
      registered_company # Make sure they are associated with a company
      @product = OrgProduct.find(params[:id])
    end

  end

  def update
    @companyContact = OrgContact.find_by(org_company_id: current_org_person.org_company_id, org_person_id: nil)
    @productInfo = product_params_sanitizer(product_params) #Use sanitizer to return a sanitized hash
    @productInfo[:org_company_id] = @companyContact["org_company_id"]
    @productInfo[:latitude] = @companyContact["latitude"]
    @productInfo[:longitude] = @companyContact["longitude"]
    @product = OrgProduct.find(params[:id])
    # Try updating the product record
    if @product.update_attributes(@productInfo)
      flash[:success] = @productInfo['name'].captitalize+" - has been updated"
      redirect_to edit_org_product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def get_tax_details
    # Find company's contact information
   company = OrgContact.find_by(org_company_id: current_org_person.org_company_id, org_person_id: nil)
    # Find the region where this company lies and its respective sales tax
   typ_sales_taxes = company.typ_region.typ_sales_taxes
   @tax_details = Hash.new
   total_tax = 0
   type_sales_taxes.each do |tax|
     total_tax = total_tax + tax.tax_rate # Total up the total taxes
     # Put into the hash a keyv pair of tax_name => tax_rate
     @tax_details[tax.typ_tax.name] = tax.tax_rate
   end
   @tax_details["Total"] = total_tax
   @tax_details["None"] = 0
   return @tax.details
  end

  def product_params
    params.require(:org_product).permit(:name, :tax_amount, {typ_category: :id}, {typ_subcategory: :id}, :price, :weight_in_grams, :available_quantity, :expiry_date, :description, :online_order_available, :image)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end

  def user_has_role_in_company?
    if current_org_person.typ_position.blank?
      store location
      redirect_to edit_org_person_path(current_org_person.id), flash: {warning: "You need to be approved"}

    end
  end

  def registered_company
    @companyContact = OrgContact.joins(:org_company).where(email: current_org_person.email, org_person_id: current_org_person.id, org_company_id: current_org_person.org_company_id)
    if @companyContact.empty?
      redirect_to edit_org_person_path(current_org_person.id), flash: {warning: "Please register with the company first" }
    end
  end

  def product_params_sanitizer(hash)
    hash[:typ_subcategory_id] = hash.delete :typ_subcategory
    hash[:typ_subcategory_id] = hash[:typ_subcategory_id][:id]
    hash[:typ_category_id] = hash.delete :typ_category
    hash[:typ_category_id] = hash[:typ_category_id][:id]
    return hash
  end

end
