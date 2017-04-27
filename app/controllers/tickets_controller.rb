class TicketsController < ApplicationController

  before_action :set_project
  before_action :set_ticket ,only:[:show,:destroy,:edit,:update]
  def new
    @ticket = @project.tickets.build
    authorize @ticket,:create?
    3.times{@ticket.attachments.build}
  end

  def create

    @ticket = @project.tickets.build(ticket_param)
    @ticket.auther = current_user
    authorize @ticket,:create?
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project,@ticket]
    else
      flash.now[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
    authorize @ticket ,:show?
  end

  def edit
    authorize @ticket,:update?
  end

  def update
    authorize @ticket,:update?
    if(@ticket.update(ticket_param))
      flash[:notice] = "Ticket has been updated."
      redirect_to project_ticket_path(@project,@ticket)
    else
      flash.now[:alert]  = "Ticket has not been updated."
      render :edit
    end
  end

  def destroy
    authorize @ticket,:destroy?
    @ticket.destroy
    flash[:notice]="Ticket has been deleted."

    redirect_to @project
  end
  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def ticket_param
      #加上attachments_attributes里的id，可以更新附件，否则会增加附件
      params.require(:ticket).permit(:name,:description,attachments_attributes: [:file,:file_cache,:id])
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end
end
