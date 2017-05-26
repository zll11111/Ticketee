class CommentsController < ApplicationController

  before_action :set_ticket

  def create


    @comment = @ticket.comments.build(sanitized_parameters)
    @comment.auther = current_user
    authorize(@comment,:create?)
    if(@comment.save)
      flash[:notice] ="Comment has been created."
      redirect_to project_ticket_path(@ticket.project,@ticket)
    else
      flash.now[:alert] = "Comment has not been created."
      @project = @ticket.project
      render "tickets/show"
    end
  end

  def sanitized_parameters
    whitelisted_params = comment_params
    unless policy(@ticket).change_state?
      whitelisted_params.delete(:state_id)
    end

    unless policy(@ticket).tag?
      whitelisted_params.delete(:tag_names)
    end
    whitelisted_params
  end
  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text,:state_id,:tag_names)
  end


end
