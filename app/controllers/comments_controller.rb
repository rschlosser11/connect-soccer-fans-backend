class CommentsController < ApplicationController 
    def index
        if params[:fixture_id]
            fixture = Fixture.find(params[:fixture_id])
            comments = Comment.where(fixture: fixture).desc
        else
            comments = Comment.desc
        end
        render json: comments.to_json({
                include: {
                    user: {
                        only: [:username]
                    } 
                },
                except: [:create_at, :updated_at]
            })
    end

    def create 
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment.to_json({
                include: {
                    user: {
                        only: [:username]
                    } 
                },
                except: [:create_at, :updated_at]
            })
        end
    end

    private 

    def comment_params
        params.require(:comment).permit(:text, :fixture_id, :user_id)
    end
end 