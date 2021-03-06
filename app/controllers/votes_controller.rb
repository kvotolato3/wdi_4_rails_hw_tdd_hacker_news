class VotesController < ApplicationController
  before_action :set_votable
  before_action :authenticate_user!

  def create
    @vote = @votable.votes.new(value: params[:score], user: current_user)
    if @vote.save
      @votable.score = @votable.votes.sum(:value)
      @votable.save
      redirect_to :back, { notice: 'Vote accepted. Thanks!' }
    else
      redirect_to :back
    end
  end


  private
    def set_votable
      @votable = params[:votable].classify.constantize.find(votable_id)
    end
    def votable_id
      params[(params[:votable] + "_id").to_sym]
    end
end

