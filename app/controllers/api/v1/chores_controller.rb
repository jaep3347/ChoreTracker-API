module Api::V1
class ChoresController < ApplicationController
    swagger_controller :chores, "Chore Management"
  
    swagger_api :index do
        summary "Fetches all Chore"
        notes "This lists all the chores"
        param :query, :done, :boolean, :optional, "Filter on whether or not the chore is completed"
        param :query, :upcoming, :boolean, :optional, "Filter on whether or not the chore is upcoming"
        param :query, :chronological, :boolean, :optional, "Order task by chronological"
        param :query, :by_task, :boolean, :optional, "Order task by task    "
    end
        
    swagger_api :show do
        summary "Shows one Chore"
        param :path, :id, :integer, :required, "Chore ID"
        notes "This lists details of one chore"
        response :not_found
    end

    swagger_api :create do
        summary "Creates a new Chore"
        param :form, :child_id, :integer, :required, "Child ID"
        param :form, :task_id, :integer, :required, "Task ID"
        param :form, :due_on, :date, :required, "Due Date"
        param :form, :active, :boolean, :required, "Completed"
        response :not_acceptable
    end

    swagger_api :update do
        summary "Updates an existing Chore"
        param :path, :id, :integer, :required, "Chore Id"
        param :form, :child_id, :integer, :optional, "Child ID"
        param :form, :task_id, :integer, :optional, "Task ID"
        param :form, :due_on, :date, :optional, "Due Date"
        param :form, :active, :boolean, :optional, "Completed"
        response :not_found
        response :not_acceptable
    end

    swagger_api :destroy do
        summary "Deletes an existing Chore"
        param :path, :id, :integer, :required, "Chore Id"
        response :not_found
    end
  
    before_action :set_chore, only: [:show, :update, :destroy]

    # GET /chores

    def index
        @chores = Chore.all
        if(params[:pending].present?)
            @chores = params[:pending] == "true" ? @chores.pending : @chores.done
        end
        if(params[:upcoming].present?)
            @chores = params[:upcoming] == "true" ? @chores.upcoming : @chores.past
        end
        if params[:chronological].present? && params[:chronological] == "true"
            @chores = @chores.chronological
        end
        if params[:by_task].present? && params[:by_task] == "true"
            @chores = @chores.by_task
        end
        
        render json: ChoreSerializer.new(@chores)
    end

    # GET /chores/1
    def show
        render json: ChoreSerializer.new(@chore)
    end

    # POST /chores
    def create
        @chore = Chore.new(chore_params)

        if @chore.save
            render json: ChoreSerializer.new(@chore), status: :created, location: [:v1, @chore]
        else
        render json: @chore.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /chores/1
    def update
        if @chore.update(chore_params)
            render json: ChoreSerializer.new(@chore)
        else
        render json: @chore.errors, status: :unprocessable_entity
        end
    end

    # DELETE /chores/1
    def destroy
        @chore.destroy
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_chore
        @chore = Chore.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def chore_params
        params.permit(:child_id, :task_id, :due_on, :completed)
        end
end
end