### begin derdy patch, helmet required ###
module RSpec
  module Core
    class ExampleGroup
      def self.define_example_method(name, extra_options={})
        module_eval(<<-END_RUBY, __FILE__, __LINE__)
          def self.#{name}(desc=nil, *args, &block)
            options = build_metadata_hash_from(args)
            options.update(:pending => true) unless block
            options.update(#{extra_options.inspect})

            calculate_iterations(options).times do
              examples << RSpec::Core::Example.new(self, desc, options, block)
            end

            #shuffle examples for good perf simulation
            examples.shuffle!
            examples.last
          end
        END_RUBY
      end

      define_example_method :example

      class << self
        alias_method :alias_example_to, :define_example_method
      end

      alias_example_to :it
      alias_example_to :specify
      alias_example_to :focused, :focused => true, :focus => true
      alias_example_to :focus,   :focused => true, :focus => true
      alias_example_to :pending, :pending => true
      alias_example_to :xit,     :pending => true
    end
  end
end