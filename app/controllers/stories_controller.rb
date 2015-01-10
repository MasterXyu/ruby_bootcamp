class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @storyfeed = current_user.storyfeed
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.new(content: params[:story][:content])
    Neo4j::Transaction.run do |tx|
      if @story.save
        current_user.stories << @story
        redirect_to @story
      else
        render 'new'
      end
    end
  end

  def destroy
  end
end
