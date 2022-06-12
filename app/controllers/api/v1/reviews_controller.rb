module Api 
    module V1
        class ReviewsController < ApplicationController

            protect_from_forgery with: :null_session #this line is not required for read, this is added to have write permission

            def index
                puts "hello"
                reviews = Review.all
                render json: ReviewSerializer.new(reviews).serialized_json
            end

            # def show
            #     review = Review.find_by(slug: params[:slug])
            #     render json: ReviewSerializer.new(review).serialized_json
            # end
            
            def create
                puts "hey"
                review = Review.new(review_params)

                if review.save
                    render json: ReviewSerializer.new(review).serialized_json
                else
                    render json: {error: review.errors.messages }
                end
            end

            def destroy
                review = Review.find(params[:id])

                if review.destroy
                    head :no_content
                else
                    render json: {error: review.errors.messages }
                end
            end



            private
            def review_params
                params.require(:review).permit(:title, :description, :score, :airline_id)
            end
        end
    end
end 