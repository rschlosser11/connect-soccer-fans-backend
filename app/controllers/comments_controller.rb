class CommentsController < ApplicationController 
    def index
        fixture = Fixture.find(params[:fixture_id])
        if fixture
            comments = Comment.where(fixture: fixture)
            render json: comments.to_json({
                include: {
                    user: {
                        only: [:username]
                    } 
                },
                except: [:create_at, :updated_at]
            })
        end
    end
end 