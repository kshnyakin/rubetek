class FlatPolicy < ApplicationPolicy

  def last_flat_counters?
    puts "checking PostPolicy#last_flat_counters"
    user.is_admin?
  end

  def debtor_list?
    puts "checking PostPolicy#debtor_list"
    user.is_admin?
  end

  def index?
    true
  end

  def create?
    user.is_admin?
  end

  def show?
    user.is_admin? || record.user_id = user.id
  end

  def update?
    user.is_admin? || record.user_id = user.id
  end

  def destroy?
    user.is_admin?
  end

end
