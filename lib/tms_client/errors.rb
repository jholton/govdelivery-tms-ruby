module TMS
  module Errors
    class ServerError
      def initialize(response)
        super("TMS client encountered a server error: #{response.status} \n#{response.body}")
      end
    end
    class NoRelation < StandardError
      def initialize(rel=nil, obj=nil)
        message = "no link relation "
        message << "'#{rel}' " if rel
        message << 'is available'
        message << " for #{obj}" if obj
        super(message)
      end
    end
    class InvalidVerb
      attr_reader :record

      def initialize(record_or_string)
        if record_or_string.respond_to?(:href)
          @record = record_or_string
          super("Couldn't POST #{record.class} to #{record.href}: #{record.errors.join(', ')}")
        else
          super(record_or_string)
        end

      end
    end
    class InvalidPost < InvalidVerb
    end
    class InvalidPut < InvalidVerb
    end
    class InvalidDelete < InvalidVerb
    end
    class InvalidGet < StandardError
      def initialize(message=nil)
        super(message || "Can't GET a resource after an invalid POST; either create a new object or fix errors")
      end
    end
  end
end