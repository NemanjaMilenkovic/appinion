class PollsController < ApplicationController
    def index
        @polls = Poll.all
    end

    def show 
        @poll = Poll.find_by(id: params[:id]) 
        redirect_to '/' if @poll.nil? 
    end

    def create
        @poll = Poll.new
        render :form
    end

    def edit
        @poll = Poll.find_by(id: params[:id])
        redirect_to '/' if @poll.nil?

        render :form
    end

    def save
        data = poll_params.to_h
        id = data.delete :id
        @poll = if id.to_i.positive?
                    Poll.find id
                else
                    Poll.new
                end
        options = data.delete :options

        @poll.update data
        if @poll.save
            @poll.options.delete_all
            options.each { |opt| @poll.options.create label: opt }
        end

        redirect_to '/'
    end

    def remove
        poll = Poll.find_by(id: params[:id])
        redirect_to '/' if poll.nil?

        poll.delete
        redirect_to '/'
    end

    def vote
        Vote.create(option_id: params[:option])
        redirect_to action: :show, id: params[:poll], votes: params[:votes]
    end

    private

    def poll_params
        params.require(:poll)
              .permit(
                  :id,
                  :name,
                  options: []
                )
    end
end