class Module
  def add_methods(*method_names, &body)
    method_names.each do |method_name|
      define_method method_name, body
    end
  end

  def add_methods_by_hash(body, method_names)
    method_names.each do |method_name, method_value|
      new_body = eval("lambda { #{body} }", binding, __FILE__, __LINE__ + 1)
      define_method method_name, new_body
    end
  end

end

module ActiveRecord
  class Base
    Limit = 7
    TableNames = connection.select_values("show tables")

    named_scope :list, :order => "created_at desc"
    named_scope :list_by_limit, lambda {|limit| {:order => "created_at desc", :limit => limit}}
    named_scope :public, :conditions => {:conceal => false}
    named_scope :concealed, :conditions => {:conceal => true}

    attr_accessor :self_path
    
    def that_path(default_path)
      self_path || default_path
    end

    def after_new(params, session)
      atrs = self.class.column_names.grep(/_id/)
      if atrs.blank?
        return
      elsif atrs.include? "user_id"
        self.user_id = session[:user_id]
        atrs.delete("user_id")
        return if atrs.blank?
      end
      need_assign_atrs = (atrs.map {|i| i.chomp("_id").pluralize }) & TableNames
      need_assign_atrs.each do |i|
        i = i.singularize
        atr_name = i + "_id"
        send(atr_name + "=", params[atr_name])
      end
    end
    
    def after_edit(params, session)
    end  	

    def aconceal
      update_attribute(:conceal, true)
    end

    def aunconceal
      update_attribute(:conceal, false)
    end

    def conceal_path
      "/admin/#{class_to_s}s/conceal/#{id}"
    end

    def unconceal_path
      "/admin/#{class_to_s}s/unconceal/#{id}"
    end

    def class_to_s
      self.class.to_s.downcase
    end

    def show?
      @show ||= !conceal
    end

    class << self

      def per_page
        10
      end

      def ok_sql(sql)
        sanitize_sql(sql)
      end
      
    end

  end
end

module ActiveSupport

  class TimeWithZone

    def to_s_with_change
      time.strftime("%Y-%m-%d %H:%M:%S")
    end

    alias_method_chain :to_s, :change
    
  end
end


class Hash

  def safe_invert
    new_hash = {}
    self.each do |k, v|
      if v.is_a? Array
        v.each do |x|
          new_hash.add_or_append(x, k)
        end
      else
        new_hash.add_or_append(v, k)
      end
    end
    new_hash
  end

  def add_or_append(key, value)
    if has_key?(key)
      self[key] = [value, self[key]].flatten
    else
      self[key] = value
    end
  end
  
end


class Archive
  Limit = 3

  attr_accessor :auto_follow
  attr_reader :id

  def initialize(id)
    @id, @auto_follow = id.to_i, {}
  end

  def auto_follow_users
    @auto_follow.keys
  end

  def write
    self.class.write(self)
  end


  def choose_result_by_limit
    result = []
    time = 0
    set = @auto_follow.safe_invert.sort.reverse

    catch :done do
      set.each do |weight, users|
        Array(users).each do |following|
          throw :done if (time += 1) > Limit
          result << {:user_id => @id, :follow_id => following, :weight => weight}
        end
      end
    end
    
    result
  end

  class << self

    def create(user_id)
      archive = Archive.new(user_id)
      write(archive)
    end

    def read(user_id)
      YAML.load_file(generate_file_name(user_id))
    end

    def generate_file_name(user_id)
      File.join(RAILS_ROOT, "archive", user_id.to_s)
    end

    def write(archive)
      File.open(generate_file_name(archive.id), 'w') do |file|
        YAML.dump(archive, file)
      end
    end

  end
end

