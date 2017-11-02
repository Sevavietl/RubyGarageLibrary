require './lib/library/entities/entity.rb'
require 'test/unit'

class TestableEntity < Entity
    public_class_method :new
    
    attr_accessor :foo, :bar, :baz
end

class ComparableEntity < Entity
    public_class_method :new
    
    attr_accessor :id
end

class TestEntity < Test::Unit::TestCase

    def test_initializing_throws_an_error
        assert_raise(NoMethodError) do
            Entity.new
        end
    end

    def test_attributes
        params = { :foo => 'foo', :bar => 'bar', :baz => 'baz' }
        entity = TestableEntity.new(params)

        assert_equal([:foo, :bar, :baz], entity.attributes)
    end

    def test_to_hash
        params = { :foo => 'foo', :bar => 'bar', :baz => 'baz' }
        entity = TestableEntity.new(params)

        serialized = entity.to_hash

        assert_equal(params, serialized)
    end
    
    def test_initializing_ignores_non_attribute_params
        params = { :foo => 'foo', :bar => 'bar', :baz => 'baz', :quux => 'quux' }
        entity = TestableEntity.new(params)

        serialized = entity.to_hash

        assert_equal({ :foo => 'foo', :bar => 'bar', :baz => 'baz' }, serialized)
    end

    def test_equality
        one = ComparableEntity.new(:id => 1)
        two = ComparableEntity.new(:id => 1)
        three = ComparableEntity.new(:id => 2)

        assert_true(one == two)
        assert_false(one == three)
    end

end