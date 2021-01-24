# frozen_string_literal: true

require "test_helper"

class DefaultsTestPolicy < ActionPolicy::Base
end

class TestPolicyWithInvalidRuleName < Minitest::Test
  def setup
    ActionPolicy.enforce_predicate_rules_naming = true
    @policy = DefaultsTestPolicy.new user: User.new("john")
  end

  def teardown
    ActionPolicy.enforce_predicate_rules_naming = nil
  end

  def test_good_named_rule
    assert_equal :manage?, @policy.resolve_rule(:good?)
  end

  def test_bad_named_rule_without_question
    assert_raises(ActionPolicy::UnknownRule) do
      @policy.resolve_rule(:bad)
    end
  end
end
