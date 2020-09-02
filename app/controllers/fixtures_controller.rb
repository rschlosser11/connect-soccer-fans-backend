class FixturesController < ApplicationController 
    def index
        if params[:team_id]
            fixtures = Fixture.find_fixtures_by_team(params[:team_id])
        else
            fixtures = Fixture.desc_order 
        end
        render json: fixtures.to_json({
            include: {
                home_team: {
                    only: [:name]
                },
                away_team: {
                    only: [:name]
                }
            },
            except: [:create_at, :updated_at]
        })
    end

    def show
        fixture = Fixture.find(params[:id])
        render json: fixture.to_json({
            include: {
                home_team: {
                    only: [:name]
                },
                away_team: {
                    only: [:name]
                }
            },
            except: [:create_at, :updated_at]
        })
    end
end