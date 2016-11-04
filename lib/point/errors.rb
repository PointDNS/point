module Point

  ## Base level error which all other point errors will inherit from. It may also be
  ## invoked for errors which don't directly relate to other errors below.
  class Error < StandardError; end

  module Errors

    ## The service is currently unavailable. This may be caused by rate limiting or the API
    ## or the service has been disabled by the system
    class ServiceUnavailable < Error; end

    ## Access was denied to the remote service
    class AccessDenied < Error; end

    ## A communication error occured while talking to the Point API
    class CommunicationError < Error; end
  end
end
