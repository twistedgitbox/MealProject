class OrgCompaniesController < ApplicationController
	before_action :signed_in_user, :user_has_role_in_company?, only: [:show, :edit, :update, :list_deliverers, :ajax_add_deliverers, :preferred_deliverers, :people ]
	before_action :allowed_to_edit_company_info?, only: [:edit, :update]

	def new
		signed_in_user #Be sure the user is signed in before he can create a company
		@company = OrgCompany.new # Make new company object 
		@contactInfo = OrgContact.new.attributes  # Make new contact object w/ empty attributes
		@company.org_contacts.build(@contactInfo)
	end

	def create
		# Find out if the company they guy is creating exists
		if !OrgCompany.exists?(name: company_register_params["name"], typ_company_id: company_register_params["typ_companies"]["id"])
			@company = OrgCompany.create(name: company_register_params["name"], typ_company_id: company_register_params["typ_companies"]["id"], typ_fee_id: company_register_params["typ_fee_id"], description: company_register_params["description"])
			# Sanitize the parameters
			@org_ca = company_params_sanitizer(company_register_params["org_contacts_attributes"]["0"])
		    @contact = OrgContact.create(org_company_id: @company.id) #Create a contact in the db
			# If the company is created and we saved the contact information for the company
			if @company && @contact.update_attributes(@org_ca)
				# Flash success message on next screen
		    	flash[:success] = "Thank you for registering your company. The ability to edit company information can be done through the email account used to register the company"
				redirect_to edit_org_company_path(@company)	# Redirect us to company edit path
			else 
				@contactInfo = @org_ca 
				@company.org_contacts.build(@contactInfo) #Rebuild the new page with the information the user entered
				render :new #Rerender the new page
			end
		else
			flash[:danger] = "The company you are trying to register already exists!"
			@contactInfo = @org_ca 
			@company.org_contacts.build(@contactInfo) #Rebuild the new page with the information the user entered
			render :new #Rerender the new page
		end
	end

	def show 
		@company = OrgCompany.find(params[:id]) #Find the company we are dealing with
		@type_company = TypCompany.find_by_id(@company.typ_company_id) # Find the type of the company
		# Attributes used to prepopulate the input fields
		@contactInfo = OrgContact.find_or_create_by(org_company_id: params[:id], org_person_id: nil).attributes
		@country = TypCountry.find_by_id(@contactInfo['typ_country_id']) # Find the type of the company
		@region = TypRegion.find_by_id(@contactInfo['typ_region_id']) # Find the type of the company
	end

	def edit
		@company = OrgCompany.find(params[:id]) #Find the company we're dealing with
		# Attributes used to prepopulate the input fields
		@contactInfo = OrgContact.find_or_create_by(org_company_id: params[:id], org_person_id: nil).attributes
		@company.org_contacts.build(@contactInfo) # Build the contact input fields associated with company
	end

	def update
		@company = OrgCompany.find(params[:id]) #Find the company we are dealing with
		# Sanitize the parameters
		@companyInfo = {description: company_edit_params["description"], avatar: company_edit_params["avatar"]}
		@org_ca = company_params_sanitizer(company_edit_params["org_contacts_attributes"]["0"])
		@contact = OrgContact.find_or_create_by(org_company_id: @company.id, org_person_id: nil) #Find/Create a contact in the db if it doesn't exist
		@contactInfo = @contact.attributes # If the update was not sucessful, we need the previous record data to rerender the edit page
		# Try updating the the contact record  
		if @contact.update_attributes(@org_ca) && @company.update(@companyInfo)
	    	flash[:success] = "Company information updated" #Flash message success on next screen
			redirect_to edit_org_company_path(@company)	# Go back to edit page
		else 
			@company.org_contacts.build(@contactInfo) #Build the fields with the previous record data
			render :edit # Rerender edit page
		end
	end

	def people
		@people = OrgContact.where(org_company_id: current_org_person.org_company_id).where.not(org_person_id: nil)
		@cu_position = current_org_person.typ_position_id
	end

	private

		# Checks if the user is signed in, if they are skip this function, if not
		# redirect him to sign in page and save the last page they were on so
		# we can redirect him back to that page when he signs in.
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, flash: {warning: "Please sign in."}
			end
		end

		# strong parameters. These are the parameters we allow.
		def company_register_params
			params.require(:org_company).permit(:name, :avatar, :description, :typ_fee_id, {typ_companies: :id}, org_contacts_attributes: [:address1, :address2,
	        :city, {typ_countries: :id}, {typ_regions: :id}, :postal_code, :email, 
	        :business_number, :cell_number])
		end

		# strong parameters. These are the parameters we allow.
		def company_edit_params
	      params.require(:org_company).permit(:name, :avatar, :description, org_contacts_attributes: [:address1, :address2,
	        :city, {typ_countries: :id}, {typ_regions: :id}, :postal_code, :email, 
	        :business_number, :cell_number])
	    end

		# Used to sanitize the user inputs. Accepts a hash as the parameter
	    # Returns a hash that is acceptable for updating the database
		def company_params_sanitizer(hash)
			hash[:typ_country_id] = hash.delete :typ_countries
			hash[:typ_country_id] = hash[:typ_country_id][:id]
			hash[:typ_region_id] = hash.delete :typ_regions
		    hash[:typ_region_id] = hash[:typ_region_id][:id]
		    return hash
		end

		 # To see orders, products, company, the person should have a role in the company
	    def user_has_role_in_company?
	    	if current_org_person.typ_position_id.blank?
	    		redirect_to edit_org_person_path(current_org_person.id), flash: {warning: "You need to be approved by the company you have been assigned to first to access the requested page."}
	    	end
	    end

	    # Only COO, Director, and Regional Manager are allowed to edit company info
	    def allowed_to_edit_company_info?
	    	position = current_org_person.typ_position_id.to_i
	    	if position == 1 || position == 2 || position ==3
	    		true
	    	else 
	    		false
	    		redirect_to edit_org_person_path(current_org_person.id), flash: {warning: "Access is restricted for your role."}
	    	end
	    end

end
