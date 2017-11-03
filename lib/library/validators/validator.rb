class Validator
    attr_reader :messages

    def initialize
        @messages_patterns = {
            :required => '%s is required',
            :integer => '%s must be an integer',
            :exists => '%s must exist',
            :email => '%s must be an email',
            :unique => '%s must be unique'
        }
    
        @messages = {}
    end

    def set_inputs(inputs)
        @inputs = inputs
        self
    end

    def fails?
        @inputs.inject(false) { |acc, (name, value)| !validate(name, value) || acc }
    end

    def validate(name, value)
        return true unless @rules&.has_key?(name)

        errors = []
        parse_rules(@rules[name]).each do |rule|
            rule, *params = parse_rule(rule)

            if !send("validate_#{rule}".to_sym, value, *params)
                errors << (@messages_patterns[rule.to_sym] % name)
            end
        end

        if !errors.empty?
            @messages[name] = errors
            return false
        end

        true
    end

    private

    def parse_rules(rules)
        rules.split('|')
    end

    def parse_rule(rule)
        rule.split(':')
    end

    def validate_required(value)
        value != nil && value != ''
    end

    def validate_integer(value)
        value.is_a?(Integer) || value.to_i.to_s == value
    end

    def validate_email(value)
        validate_regex(value, '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
    end

    def validate_regex(value, regex)
        /#{regex}/.match(value)
    end

    def validate_exists(value, entity)
        validate_integer(value) && (get_repo(entity).find(value.to_i) != nil)
    end

    def validate_unique(value, entity, field)
        get_repo(entity).query({ :field => field.to_sym, :sign => :==, :value => value }).empty?
    end

    def get_repo(enity)
        Object.const_get("#{singularize(enity.to_s).capitalize}Repo")
    end

    def singularize(string)
        string.chomp('s')
    end
end
