module NoPeeking #:nodoc:
  mattr_accessor :default_users
  @@default_users = {'client' => 'alpha#4321' }

  def self.included(target)
    target.extend(ActiveRecordBaseMethods)
  end

  module ActiveRecordBaseMethods

    def no_peeking(environments = ["staging", "production"])
      include NoPeeking::InstanceMethods
      self.prepend_before_filter { http_authenticate(environments) }
    end

    def set_users(users ={})
      NoPeeking.default_users = users
    end

  end

  module InstanceMethods

    def http_authenticate(environments = [])
      return unless environments.include?(Rails.env)
      authenticate_or_request_with_http_basic do |username, password|
       NoPeeking.default_users.fetch(username, false) == password
      end
    end

  end


end
