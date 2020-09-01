class FixturesController < ApplicationController 
    def index
        if params[:team_id]
            fixtures = Fixture.find_fixtures_by_team(params[:team_id])
        else
            fixtures = Fixture.all 
        end
        render json: fixtures, except: [:created_at, :updated_at]
    end

    def show
        fixture = Fixture.find(params[:id])
        render json: fixture, except: [:created_at, :updated_at]
    end
end