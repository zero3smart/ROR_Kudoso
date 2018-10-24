module Api
  module V1
<<<<<<< HEAD
    class TodosController < ApiController
      # This controller is only callable through the family
      # /api/v1/family/:family_id/todos

      resource_description do
        short 'Family Todos (also know as Tasks)'
=======
    class TodoTemplatesController < ApiController

      resource_description do
        short 'API Todo Templates (also know as Task Templates)'
>>>>>>> 992a42491dc2ec4b996eb28aaa06b5466fdfeeaa
        formats ['json']
        api_version "v1"
        error code: 401, desc: 'Unauthorized'
        error 404, "Missing"
        error 500, "Server processing error (check messages object)"
        description <<-EOS
<<<<<<< HEAD
          == Todos (Tasks )
          Tasks are parent directed activities, as parents assign tasks to kids, a Todo object is created at the family
          level to track that task across one or more schedules which assign the task to each child.

          Here is how the association works:
=======
          == Todo_Template (Task Templates)
          Tasks are parent directed activities, the task templates are a collection of pre-defined templates that
          Kudoso provides to make it easy for parents to assign them.

          Todo_templates should not be confused with Todos or my_todos.  Here is how the association works:
>>>>>>> 992a42491dc2ec4b996eb28aaa06b5466fdfeeaa
          1. When a todo_template is "assigned", a Todo is created at the FAMILY level
          2. A todo_schedule is created (initially from the defaults in the todo_template) which links the todo to
             a family member
          3. A my_todo is an instance of a todo_schedule for a member on a particular day.  In effect, the my_todo
             records the details of the actual task performed

<<<<<<< HEAD
        EOS
      end

      def_param_group :todos do
        param :name, String, desc: 'The name of the task to be displayed in the task list/calendar', required: true
        param :description, String, desc: 'A more detailed description of the task to help guide the child'
        param :required, [true, false], desc: 'If a task is required, a child will be prevented from doing other activities until it is complete', required: true
        param :kudos, Integer, desc: 'The number of kudos that can be earned by completing the task', required: true
        param :active, [true, false], desc: 'Set to true in order to use', required: true
        param :schedule, String, desc: 'A YAML representation of an IceCube Recurring Rule.  See https://github.com/seejohnrun/ice_cube and https://github.com/GetJobber/recurring_select', required: true
      end

      api :GET, "/v1/families/:family_id/todos", "Retrieve all todos for the family"
      def index
        messages = init_messages
        begin
          @family = Family.find(params[:family_id])
          if @current_user.try(:admin) || (@current_member.try(:family) == @family && @current_member.try(:parent) )
            render :json => { todos: @family.todos, :messages => messages }, :status => 200
          else
            messages[:error] << 'You are not authorized to do this.'
            render :json => { :messages => messages }, :status => 403
          end

        rescue ActiveRecord::RecordNotFound
          messages[:error] << 'Family not found.'
          render :json => { :messages => messages }, :status => 404
        rescue
          messages[:error] << 'A server error occurred.'
          render :json => { :messages => messages }, :status => 500
        end
      end

      api :GET, "/v1/families/:family_id/todos/:todo_id", "Retrieve a specific todo for the family"
=======
          === Key attributes
          * __rec_min_age__ This is the recommended minimum age for the task
          * __rec_max_age__ This is the recommended maximum age for the task
          * __def_min_age__ If the member's age is >= to def_min_age it should be selected by default (in the wizard)
          * __def_max_age__ If the member's age is <= to def_max_age it should be selected by default (in the wizard)

        EOS
      end

      api :GET, "/v1/families/:family_id/members/:member_id/todo_templates", "Retrieve all task templates assigned to a member"
      api :GET, "/v1/todo_templates", "Retrieve all task templates"
      def index
        messages = init_messages
        if params[:family_id] && params[:id]
          begin
            @family = Family.find(params[:family_id])
            if @current_user.try(:admin) || (@current_member.try(:family) == @family )
              @member = @family.members.find(params[:id])
              render :json => { :todo_templates => @member.todo_templates, :messages => messages }, :status => 200
            else
              messages[:error] << 'You are not authorized to do this.'
              render :json => { :messages => messages }, :status => 403
            end
          rescue ActiveRecord::RecordNotFound
            messages[:error] << 'Family or Member not found.'
            render :json => { :messages => messages }, :status => 404
          rescue
            messages[:error] << 'A server error occurred.'
            render :json => { :messages => messages }, :status => 500
          end
        else
          @todo_templates = TodoTemplate.all
          render :json => { :todo_templates => @todo_templates, :messages => messages }, :status => 200
        end


      end

      api :GET, "/v1/todo_templates/:todo_template_id", "Retrieve a single task template"
>>>>>>> 992a42491dc2ec4b996eb28aaa06b5466fdfeeaa
      def show
        messages = init_messages
        begin
          @family = Family.find(params[:family_id])
          @member = @family.members.find(params[:member_id])
          @todo = @family.todos.find(params[:id])
          if @current_user.try(:admin) || (@current_member.try(:family) == @family && @current_member.try(:parent) )
            render :json => { :todo => @todo, :messages => messages }, :status => 200
          else
            messages[:error] << 'You are not authorized to do this.'
            render :json => { :messages => messages }, :status => 403
          end

        rescue ActiveRecord::RecordNotFound
          messages[:error] << 'Family or Member not found.'
          render :json => { :messages => messages }, :status => 404
        rescue
          messages[:error] << 'A server error occurred.'
          render :json => { :messages => messages }, :status => 500
        end

      end

<<<<<<< HEAD
      api :POST, "/v1/families/:family_id/todos", "Create a new todo (manual, not from a todo_template)"
      param_group :todos
      def create
=======
      api :POST, "/v1/families/:family_id/members/:member_id/todo_templates/:todo_template_id/assign", "Assign a todo_template to a member (must be a parent)"
      def assign
>>>>>>> 992a42491dc2ec4b996eb28aaa06b5466fdfeeaa
        messages = init_messages
        begin
          @family = Family.find(params[:family_id])
          if @current_user.try(:admin) || (@current_member.try(:family) == @family && @current_member.try(:parent) )
            @todo = @family.todos.create(todo_create_params)
            if @todo.valid?
              render :json => { :todo => @todo, :messages => messages }, :status => 200
            else
              messages[:error] << @todo.errors.full_messages
              render :json => { :todo => @todo, :messages => messages }, :status => 400
            end

          else
            messages[:error] << 'You are not authorized to do this.'
            render :json => { :messages => messages }, :status => 403
          end

        rescue ActiveRecord::RecordNotFound
          messages[:error] << 'Family not found.'
          render :json => { :messages => messages }, :status => 404
        rescue
          messages[:error] << 'A server error occurred.'
          render :json => { :messages => messages }, :status => 500
        end

      end

<<<<<<< HEAD
      api :PATCH, "/v1/families/:family_id/todos/:todo_id", "Update a todo"
      param_group :todos
      def update
=======
      api :DELETE, "/v1/families/:family_id/members/:member_id/todo_templates/:todo_template_id/unassign", "Remove a todo_template from a member (must be a parent)"
      def unassign
>>>>>>> 992a42491dc2ec4b996eb28aaa06b5466fdfeeaa
        messages = init_messages
        begin
          @family = Family.find(params[:family_id])
          @todo = @family.todos.find(params[:id])
          if @current_user.try(:admin) || (@current_member.try(:family) == @family && @current_member.try(:parent) )
            if @todo.update_attributes(todo_create_params)
              render :json => { :todo => @todo, :messages => messages }, :status => 200
            else
              messages[:error] << @todo.errors.full_messages
              render :json => { :todo => @todo, :messages => messages }, :status => 400
            end

          else
            messages[:error] << 'You are not authorized to do this.'
            render :json => { :messages => messages }, :status => 403
          end

        rescue ActiveRecord::RecordNotFound
          messages[:error] << 'Family not found.'
          render :json => { :messages => messages }, :status => 404
        rescue
          messages[:error] << 'A server error occurred.'
          render :json => { :messages => messages }, :status => 500
        end

      end

      api :DELETE, "/v1/families/:family_id/todos/:todo_id", "Delete a todo"
      def destroy
        messages = init_messages
        begin
          @family = Family.find(params[:family_id])
          if @current_user.try(:admin) || (@current_member.try(:family) == @family && @current_member.try(:parent) )
            @todo = @family.todos.find(params[:id])
            if @todo.destroy
              render :json => { :todo => @todo, :messages => messages }, :status => 200
            else
              messages[:error] << @todo.errors.full_messages
              render :json => { :todo => @todo, :messages => messages }, :status => 400
            end

          else
            messages[:error] << 'You are not authorized to do this.'
            render :json => { :messages => messages }, :status => 403
          end

        rescue ActiveRecord::RecordNotFound
          messages[:error] << 'Family not found.'
          render :json => { :messages => messages }, :status => 404
        rescue
          messages[:error] << 'A server error occurred.'
          render :json => { :messages => messages }, :status => 500
        end

      end



      private


      # Never trust parameters from the scary internet, only allow the white list through.
      def todo_create_params
        params.require(:todo).permit(:name, :description, :required, :kudos, :active, :schedule)
      end

    end

  end
end