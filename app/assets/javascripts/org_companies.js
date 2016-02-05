jQuery(function() {

  $('.org_companies.show, .org_companies.edit').ready(function() {
    return $('li.sidebar_company_info').addClass('active');
  });

  $('.org_companies.people').ready(function() {
    return $('li.sidebar_company_people').addClass('active');
  });

  $('#roster').change(function() {
    var org_person_id, position;
    position = $('#roster :selected').val();
    org_person_id = $('#roster').attr('org_person_id');
    return $.ajax({
      url: "/org_people/edit_position",
      method: "POST",
      data: {
        id: org_person_id,
        typ_position_id: position
      },
      dataType: "html",
      success: location.reload()
    });
  });

  $('button.edit-role').click(function() {
    var org_person_id;
    org_person_id = $('button.edit-role').attr('org-person-id');
    return $.ajax({
      url: "/org_people/edit_position",
      method: "POST",
      data: {
        id: org_person_id,
        typ_position_id: null
      },
      dataType: "html",
      success: location.reload()
    });
  });

  $('button.remove-roster').click(function() {
    var org_person_id;
    org_person_id = $('button.remove-roster').attr('org-person-id');
    return $.ajax({
      url: "/org_people/remove_from_company",
      method: "POST",
      data: {
        id: org_person_id,
        typ_position_id: 0
      },
      dataType: "html",
      success: location.reload()
    });
  });

  var readURL, regions;
  
  regions = $('#org_company_org_contacts_attributes_0_typ_regions_id').html();
  $('#org_company_org_contacts_attributes_0_typ_countries_id').change(function() {
    var country, escaped_country, options;
    country = $('#org_company_org_contacts_attributes_0_typ_countries_id :selected').text();
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    options = $(regions).filter("optgroup[label='" + escaped_country + "']").html();
    if (options) {
      $('#org_company_org_contacts_attributes_0_typ_regions_id').html(options).addClass('form-control');
      return $('#org_company_org_contacts_attributes_0_typ_regions_id').show();
    } else {
      $('#org_company_org_contacts_attributes_0_typ_regions_id').empty(options);
      return $('#org_company_org_contacts_attributes_0_typ_regions_id').hide(options);
    }
  });
  $('.deleteCompanyPhoto').hide();
  if ($('.companyPhoto').length) {
    $('.companyPhotoPreview').hide();
  }
  $('.companyPhoto').click(function() {
    $('.companyPhoto').hide();
    $('.companyPhotoPreview').show().trigger('click');
  });
  $('.companyPhotoPreview').click(function() {
    $(this).attr('disabled', 'true');
    $('#uploadCompanyAvatar').trigger('click');
    $('#uploadCompanyAvatar').change(function() {
      $('.companyPhotoPreview').removeAttr('disabled');
      readURL(this);
    });
  });
  readURL = function(input) {
    var reader;
    if (input.files && input.files[0]) {
      reader = new FileReader;
      reader.onload = function(e) {
        $('.companyPhotoPreview').css('background', 'url(' + e.target.result + ')');
        return $('.companyPhotoUpload, #uploadClick').hide();
      };
      $('.deleteCompanyPhoto').show();
      reader.readAsDataURL(input.files[0]);
    }
  };
  return $('.deleteCompanyPhoto').click(function() {
    $('.deleteCompanyPhoto').hide();
    $('#uploadCompanyAvatar').val('');
    $('.companyPhotoPreview').css('background', '');
    if ($('.companyPhoto').length) {
      $('.companyPhoto').show();
      $('.companyPhotoPreview').hide();
    } else {
      $('.companyPhotoUpload, #uploadClick').show();
    }
  });
});