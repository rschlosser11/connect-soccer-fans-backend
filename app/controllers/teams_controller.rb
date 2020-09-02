class TeamsController < ApplicationController 
    def index
        teams = Team.alphabetical 
        render json: teams, except: [:created_at, :updated_at]
    end

    def show
        team = Team.find(params[:id])
        render json: team, except: [:created_at, :updated_at]
    end
end