class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_story

  def create
    @story = Story.find(params[:story_id])
    fail 'bad info' unless @story && params[:replied_to][:content]
    @reply = RepliedTo.new(from_node: current_user, to_node: @story, content: params[:replied_to][:content])
    if @reply.save
      redirect_to @story
    else
      raise 'wtf, man'
    end
  end

  def new
    @story = Story.find(params[:story_id])
    @reply = RepliedTo.new
  end

  def edit
  end

  def destroy
  end

  private

  def get_story
    @story = Story.find(params[:story_id])
    redirect_to home_path unless @story
  end
end
