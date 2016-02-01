class OrgCompany < ActiveRecord::Base
  has_and_belongs_to_many :org_contacts
  has_many :org_persons
  has_many :org_products

  belongs_to :type_company, foreign_key: "type_company_id"
end
