class Api::V1::CompaniesController < ApplicationController
    # GET companies
    def index
        @companies = Company.all
        render json: @companies
    end

    # GET companies/:postcode
    def show
        @company = Company.where(:postcode => params[:postcode])
        render json: @company
    end

    private

    def company_params
        params.require(:company).permit(:name, :postcode)
    end
end
