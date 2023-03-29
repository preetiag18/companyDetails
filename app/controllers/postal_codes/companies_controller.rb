class PostalCodes::CompaniesController < ApplicationController
    # GET /:postcode/companies
    def show
        @company = Company.where(:postcode => params[:postcode])
        render json: @company
    end
end
