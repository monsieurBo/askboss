class CardsController < ApplicationController

	def index
	end

	def new
		@card = Card.new
		# @card.flash_card_id = params[:id]
	end

	def create
		@card = Card.new
		@card.question = params[:card][:question]
		@card.answer = params[:card][:answer]
		@card.flash_card_id =params[:flash_card_id]
		@card.save

		respond_to do |format|
	      if @card.save
	        format.html { redirect_to "/flash_cards/#{params[:flash_card_id]}", notice: 'Card was successfully created.' }
	      else
	        format.html { render :new }	        
	      end
    	end
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		redirect_to flash_card_path(params[:flash_card_id])
	end
end