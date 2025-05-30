require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  test "valid audit log" do
    user = User.create!(name: "Audit User", email: "audit@example.com", password: "password123")
    audit_log = AuditLog.new(event_type: :login, user: user, payload: {})
    assert audit_log.valid?
  end

  test "enum event_type" do
    assert_equal ["login", "logout", "operation", "data_change", "error"], AuditLog.event_types.keys
  end

  test "belongs to user" do
    assoc = AuditLog.reflect_on_association(:user)
    assert_equal :belongs_to, assoc.macro
  end
end
