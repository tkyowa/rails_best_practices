require 'rubygems'
require 'spork'

Spork.prefork do
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

  require 'rspec'

  RSpec.configure do |config|
    config.after do
      RailsBestPractices::Prepares.clear
    end
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end

  def parse_content(content)
    Sexp.from_array(Ripper::SexpBuilder.new(content).parse)[1]
  end
end

Spork.each_run do
  require 'rails_best_practices'
end

