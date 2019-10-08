class Authentication 
    attr_accessor :user, :token, :errors
  
    def initialize
      @user = nil
      @token = nil
      @errors = {}
    end
  
    def start_session(credentials)
      single_login(credentials)
      @token = Token.create(user:@user) if @user #Looking at the user controller we use .new and render, but in the sessions_controller we are supossed to render according with the method allowed?  
    end
  
    def allowed?
      not @user.nil? 
    end
  
    private
    def single_login(credentials)
      credentials[:email] ||= ''
      credentials[:cc] ||= ''
      @user = User.find_by(email: credentials[:email].downcase)
      @user = nil unless @user && @user.authenticate(credentials[:password])#.to_s.downcase) 
      @errors[:single_authentication] = 'invalid credentials' unless @user
    end
  end
  