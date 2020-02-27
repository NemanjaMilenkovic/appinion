class PollsController < ApplicationController
    def index
        @polls = Poll.all
        # @poll = Poll.new
    end

    def show @poll = Poll.find_by(id: params[:id]) redirect_to '/' if @poll.nil? end

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
        num = data.count :options
        if @poll.save and options.count.positive? :options
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
        redirect_to action: :show, id: params[:poll]
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