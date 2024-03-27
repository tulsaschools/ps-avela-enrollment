# frozen_string_literal: true

require 'dotenv/load'
require 'pry'
require_relative '../power_school'

class Console
  def initialize
    ## https://github.com/pry/pry/blob/93cfc111630940a840ccc8ed2d2485430405c9c2/bin/pry
    # Process command line options and run Pry
    opts = Pry::CLI.parse_options
    Pry::CLI.start(opts)
  end
end
