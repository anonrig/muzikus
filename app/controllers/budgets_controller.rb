class BudgetsController < ApplicationController
    before_action :set_rights
    def index
        @budgets = Budget.all.order('created_at DESC')
		@newBudget = Budget.new
		@total = Budget.where(budget_type: "Income").sum(:amount) - Budget.where(budget_type: "Expense").sum(:amount)
    end

    def create
        @budget = Budget.new(budget_params)
		@budget.save!
		redirect_to admin_budget_path
    end

    private

        def set_rights
            if current_user && current_user.is_member
                if not current_user.is_myk
                    redirect_to root_path
                end
            else
                redirect_to root_path
            end
        end

        def budget_params
            params.require(:budget).permit(:amount, :reason, :budget_type, :user_id)
        end
end