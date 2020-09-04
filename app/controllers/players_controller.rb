class PlayersController < ApplicationController 
    def index
        if params[:teams_id]
            players = Player.where(team: Team.find(params[:team_id]))
            render json: players, except: [:created_at, :updated_at]
        else
            players = Player.all
            render json: players, except: [:created_at, :updated_at]
        end
    end 
end