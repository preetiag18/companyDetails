require 'sidekiq-scheduler'
require 'rest-client'
require 'json'

class FetchCompaniesJob
  include Sidekiq::Worker

  def perform
    Postcode.all.each do |postcodeData|
      companies = fetch_companies_for_postcode(postcodeData)
      save_companies(companies)
      puts "Companies from postcode " + postcodeData.postcode + "have been loaded"
    end
  end

  private

  def fetch_companies_for_postcode(postcodeData)
    puts "Fetching companies from postcode " + postcodeData.postcode + "..."
    url = "http://avoindata.prh.fi/bis/v1?maxResults=20&streetAddressPostCode=#{postcodeData.postcode}"
    response = RestClient.get(url, {accept: :json})
    parsedResponse = JSON.parse(response)
    prepare_companies(parsedResponse["results"], postcodeData)
  end

  def prepare_companies(data, postcodeData)
    data.map do |d|
      Company.new(business_id: d["businessId"], name: d["name"], postcode: postcodeData, details_uri: d["detailsUri"] )
    end
  end

  def save_companies(companies)
    Company.transaction do
      companies.each do |company|
        existing_company = Company.find_by(business_id: company.business_id)
        if existing_company
          company.created_at = existing_company.created_at
          company.updated_at = Time.current
          existing_company.postcode = company.postcode
          existing_company.update(company.attributes.except('postcode'))
        else
          company.save!
        end
      end 
    end
  end
end