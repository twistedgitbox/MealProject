class OrgPeopleController < ApplicationController
  def edit
    @person = OrgPerson.find(params[:id])
    @contactinfo = OrgContact.find_or_initialize_by(org_person_id: params[:id])
    @contactInfo[:email] = current_org_person.email
    @person.org_contacts.build(@contactInfo.attributes)
  end
end
