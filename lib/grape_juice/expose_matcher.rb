module GrapeJuice
  module ExposeMatcher

    def expose(exposure)
      ExposeMatcher.new(exposure)
    end

    class ExposeMatcher

      def initialize(exposure)
        @expected_exposure = exposure
      end

      def matches?(subject)
        @subject = subject

        verify_entity &&
          exposure_correct? &&
          as_correct? &&
          if_conditions_correct? &&
          unless_conditions_correct? &&
          format_correct? &&
          safe_correct?
      end

      def as(exposure_name)
        @as_exposure = exposure_name
        self
      end

      def if(conditions)
        @if_conditions = conditions
        self
      end

      def unless(conditions)
        @unless_conditions = conditions
        self
      end

      def using(other_entity)
        @using_entity = other_entity
        self
      end

      def format_with(formatter)
        @formatter = formatter
        self
      end

      def safe(value)
        @safe = !!value
        self
      end

      def failure_message
        @failure_message
      end

      def failure_message_when_negated
        @negated_failure_message
      end

      def description
        "Tests the expose method for kinds of Grape::Entity."
      end

      private

      def representee
      end

      def exposure
        entity.exposures[@expected_exposure]
      end

      def entity
        @subject.respond_to?(:new) ? @subject.new(representee) : @subject
      rescue ArgumentError
      end

      def verify_entity
        if !entity.kind_of?(Grape::Entity)
          @failure_message = "#{@subject} is not a kind of Grape::Entity"
          @negated_failure_message = "#{@subject} is not a kind of Grape::Entity"
          false
        else
          true
        end
      end

      def exposure_correct?
        if exposure.nil?
          @failure_message = "#{@subject} does not expose #{@expected_exposure}"
          false
        else
          @negated_failure_message = "#{@subject} exposes #{@expected_exposure} when it should not"
          true
        end
      end

      def as_correct?
        return true if @as_exposure.nil?

        if @as_exposure != exposure[:as]
          @failure_message = "#{@subject} does not expose #{@expected_exposure} as #{@as_exposure}"
          false
        else
          true
        end
      end

      def if_conditions_correct?
        return true if @if_conditions.nil?

        if exposure[:if] != @if_conditions
          @failure_message = "Expected if condition #{@if_conditions}, got #{exposure[:if] || 'nil'}"
          false
        else
          true
        end
      end

      def unless_conditions_correct?
        return true if @unless_conditions.nil?

        if exposure[:unless] != @unless_conditions
          @failure_message = "Expected unless condition #{@unless_conditions}, got #{exposure[:unless] || 'nil'}"
          false
        else
          true
        end
      end

      def format_correct?
        return true if @formatter.nil?

        if exposure[:format_with] != @formatter
          @failure_message = "Expected #{@expected_exposure} to be formatted with #{@formatter}, but got #{exposure[:format_with]}"
          false
        else
          true
        end
      end

      def safe_correct?
        return true if @safe.nil?

        if @safe && @safe != exposure[:safe]
          @failure_message = "Expected safe to be #{@safe}, but got #{exposure[:safe] || 'nil'}"
          false
        else
          true
        end
      end
    end
  end
end

