$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'no_peeking'))

require 'core'

$LOAD_PATH.shift

if defined?(ActionController::Base)
  ActionController::Base.send :include, NoPeeking
end