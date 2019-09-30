module Exceptions
  class CurrentUserNotFound < StandardError; end
  class TokenExpired < StandardError; end
  class PasswordTokenExpired < StandardError; end
  class EmailVerificationTokenExpired < StandardError; end
  class NoCurrentStage < StandardError; end
end
