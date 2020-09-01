class FixturesController < ApplicationController 
    def index
        fixtures = Fixture.all 
        render json: fixtures, except: [:created_at, :updated_at]
    end

    def show
        fixture = Fixture.find(params[:id])
        render json: fixture, except: [:created_at, :updated_at]
    end
end