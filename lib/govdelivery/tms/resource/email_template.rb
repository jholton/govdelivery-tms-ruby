module GovDelivery::TMS #:nodoc:
  class EmailTemplate
    include InstanceResource

    # @!parse attr_accessor :body, :subject, :link_tracking_parameters, :macros, :open_tracking_enabled, :click_tracking_enabled
    writeable_attributes :body, :subject, :link_tracking_parameters, :macros, :open_tracking_enabled, :click_tracking_enabled, :uuid

    linkable_attributes :from_address

    # @!parse attr_reader :id, :created_at
    readonly_attributes :id, :created_at

    collection_attribute :from_address, 'FromAddress'
  end
end
