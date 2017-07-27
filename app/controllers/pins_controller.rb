class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]


	def index
		@pin = Pin.all.order("created_at DESC")
	end

	def show
	end      

	def new
		@pin = current_user.pins.build 
	end

	def create
		@pins = current_user.pins.build(pins_params)

		if @pins.save
			redirect_to @pins, notice: "Successfully created new Pin"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @pin.update(pins_params)
			redirect_to @pin, notice: "Pin was successfully updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path
	end

	def upvote
		@pin.upvote_by current_user
		redirect_back fallback_location: root_path
	end



private

	def pins_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end

end
