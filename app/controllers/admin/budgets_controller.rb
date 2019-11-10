class Admin::BudgetsController < BaseAdminController
    
    def index
        @budgets = Budget.all.order('created_at DESC')
		@newBudget = Budget.new
		@total = Budget.where(budget_type: "Income").sum(:amount) - Budget.where(budget_type: "Expense").sum(:amount)
    end

    def create
        @budget = Budget.new(budget_params)
        
        @budget.user_id = current_user.id
        
        @budget.save!
		redirect_to admin_budgets_path
    end

    private
    def budget_params
        params.require(:budget).permit(:amount, :reason, :budget_type)
    end
end