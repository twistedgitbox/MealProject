class AddCountriesRegions < ActiveRecord::Migration
  def change
    TypCountry.create(id: 840, iso: 'US', iso3: 'USA', fips: 'US', country: 'United States', continent: 'NA', currency_code:'USD', currency_name:'Dollar', phone_prefix:'1', postal_code: '^(d{9})$', languages:'en-US,es-US,haw', geonameid:'6252001')
    TypRegion.create(id: 1, typ_country_id: 4, name:'Badakhshan', timezone:'Asia/Kabul')
    TypRegion.create(id: 2, typ_country_id: 4, name:'Badghis', timezone:'Asia/Kabul')
    TypRegion.create(id: 3, typ_country_id: 4, name:'Baghlian', timezone:'Asia/Kabul')
    TypRegion.create(id: 4, typ_country_id: 4, name:'Bamian', timezone:'Asia/Kabul')
    TypRegion.create(id: 5, typ_country_id: 4, name:'Farah', timezone:'Asia/Kabul')
    TypRegion.create(id: 6, typ_country_id: 4, name:'Faryab', timezone:'Asia/Kabul')
    TypRegion.create(id: 7, typ_country_id: 4, name:'Ghazni', timezone:'Asia/Kabul')
    TypRegion.create(id: 8, typ_country_id: 4, name:'Ghow', timezone:'Asia/Kabul')
    TypRegion.create(id: 9, typ_country_id: 4, name:'Helmand', timezone:'Asia/Kabul')
    TypRegion.create(id: 10, typ_country_id: 4, name:'Herat', timezone:'Asia/Kabul')
    TypRegion.create(id: 11, typ_country_id: 4, name:'Kabul', timezone:'Asia/Kabul')
    TypRegion.create(id: 12, typ_country_id: 4, name:'Kapisa', timezone:'Asia/Kabul')
    TypRegion.create(id: 13, typ_country_id: 4, name:'Lowgar', timezone:'Asia/Kabul')
    TypRegion.create(id: 14, typ_country_id: 4, name:'Nangarhar', timezone:'Asia/Kabul')
    TypRegion.create(id: 15, typ_country_id: 4, name:'Nimruz', timezone:'Asia/Kabul')
    TypRegion.create(id: 16, typ_country_id: 4, name:'Oruzgan', timezone:'Asia/Kabul')
    TypRegion.create(id: 17, typ_country_id: 4, name:'Kandahar', timezone:'Asia/Kabul')
    TypRegion.create(id: 18, typ_country_id: 4, name:'Kunduz', timezone:'Asia/Kabul')
  end
end

