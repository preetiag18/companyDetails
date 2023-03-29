require 'rails_helper'

describe "get all companies route", :type => :request do

  before do 
    @postcodes = Postcode.create([
      {postcode: "00101"},
      {postcode: "00201"},
      {postcode: "00301"},
    ])

    @companies = Company.create([
      {
        business_id: "3086937-2",
        name: "company1",
        postcode: Postcode.find_by(postcode: "00101"),
        details_uri: "http://avoindata.prh.fi/opendata/bis/v1/3086937-2"
      },
      {
        business_id: "3086937-3",
        name: "company2",
        postcode: Postcode.find_by(postcode: "00201"),
        details_uri: "http://avoindata.prh.fi/opendata/bis/v1/3086937-3"
      },
      {
        business_id: "3086937-4",
        name: "company3",
        postcode: Postcode.find_by(postcode: "00301"),
        details_uri: "http://avoindata.prh.fi/opendata/bis/v1/3086937-4"
      },
      {
        business_id: "3086937-5",
        name: "company4",
        postcode: Postcode.find_by(postcode: "00201"),
        details_uri: "http://avoindata.prh.fi/opendata/bis/v1/3086937-5"
      }
    ])
  end

before {get '/api/v1/companies/00201'}

it 'returns a company details' do
    expect(JSON.parse(response.body).size).to eq(2)
  end

it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end