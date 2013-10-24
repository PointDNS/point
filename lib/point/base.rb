module Point
  class Base
    
    ## Store all attributes for the model we're working with.
    attr_accessor :id, :attributes, :errors
    
    ## Pass any methods via. the attributes hash to see if they exist
    ## before resuming normal method_missing behaviour
    def method_missing(method, *params)
      set = method.to_s.include?('=')
      key = method.to_s.sub('=', '')
      self.attributes = Hash.new unless self.attributes.is_a?(Hash)
      if set
        self.attributes[key] = params.first
      else
        self.attributes[key]
      end
    end
    
    class << self
      
      ## Find a record or set of records. Passing :all will return all records and passing an integer
      ## will return the individual record for the ID passed.
      def find(type, params = {})
        case type
        when :all then find_all(params)
        when Integer then find_single(type, params)
        when String then find_all(params).select {|r| r.attributes["name"] == type}.first
        else raise Point::Error, "Find requires :all, a string or an integer."
        end
      end
      
      ## Find all objects and return an array of objects with the attributes set.
      def find_all(params)
        JSON.parse(Request.new(collection_path(params)).make.output).map do |o|
          create_object(o[class_name.downcase], params)
        end
      end
      
      ## Find a single object and return an object for it.
      def find_single(id, params = {})
        o = JSON.parse(Request.new(member_path(id, params)).make.output)
        if o[class_name.downcase]
          create_object(o[class_name.downcase], params)
        else
          raise Point::Errors::NotFound, "Record not found"
        end
      end
      
      ## Post to the specified object on the collection path
      def post(path)
        Request.new(path.to_s, :post).make
      end
      
      ## Return the collection path for this model. Very lazy pluralizion here
      ## at the moment, nothing in Point needs to be pluralized with anything
      ## other than just adding an 's'.
      def collection_path(params = {})
        class_name.downcase + 's'
      end
      
      ## Return the member path for the passed ID & attributes
      def member_path(id, params = {})
        [collection_path, id].join('/')
      end
      
      ## Return the point class name
      def class_name
        self.name.to_s.split('::').last.downcase
      end
      
      private
            
      ## Create a new object with the specified attributes and getting and ID. 
      ## Returns the newly created object
      def create_object(attributes, objects = [])
        o = self.new
        o.attributes = attributes
        o.id         = attributes['id']
        for key, object in objects.select{|k,v| v.kind_of?(Point::Base)}
          o.attributes[key.to_s] = object
        end
        o
      end
    end
    
    ## Run a post on the member path. Returns the ouput from the post, false if a conflict or raises
    ## a Point::Error. Optionally, pass a second 'data' parameter to send data to the post action.
    def post(action, data = nil)
      path = self.class.member_path(self.id, default_params) + "/" + action.to_s
      request = Request.new(path, :post)
      request.data = data
      request.make
    end
    
    ## Delete this record from the remote service. Returns true or false depending on the success
    ## status of the destruction.
    def destroy
      Request.new(self.class.member_path(self.id, default_params), :delete).make.success?
    end
    
    def new_record?
      self.id.nil?
    end
    
    def save
      new_record? ? create : update
    end

    def create
      request = Request.new(self.class.collection_path(default_params), :post)
      request.data = {self.class.class_name.downcase.to_sym => attributes_to_post}
      if request.make && request.success?
        new_record = JSON.parse(request.output)[self.class.class_name]
        self.id = new_record['id']
        true
      else
        populate_errors(request.output)
        false
      end
    end

    ## Push the updated attributes to the remote. Returns true if the record was saved successfully
    ## other false if not. If not saved successfully, the errors hash will be updated with an array
    ## of all errors with the submission.    
    def update
      request = Request.new(self.class.member_path(self.id, default_params), :put)
      request.data = {self.class.class_name.downcase.to_sym => attributes_to_post}
      if request.make && request.success?
        true
      else
        populate_errors(request.output)
        false
      end
    end
    
    private
    
    ## Populate the errors hash from the given raw JSON output
    def populate_errors(json)
      self.errors = Hash.new
      JSON.parse(json).inject(self.errors) do |r, e|
        r[e.first] = e.last
        r
      end
    end
    
    ## An array of params which should always be sent with this instances requests
    def default_params
      Hash.new
    end
    
    ## Attributes which can be passed for update & creation
    def attributes_to_post
      self.attributes.inject(Hash.new) do |r,(key,value)|
        r[key] = value if value.is_a?(String) || value.is_a?(Integer) || value.is_a?(Fixnum)
        r
      end
    end
    
  end
end
