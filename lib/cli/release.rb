# frozen_string_literal: true

require 'nokogiri'
require 'zip'

class Release
  ## Constants
  ##
  NS = { plugin: 'http://plugin.powerschool.pearson.com' }
  PLUGIN_SELECTOR = '//plugin:plugin'

  def dist
    ## Paths
    ##
    src_path = File.absolute_path File.join(File.dirname(__FILE__), '..', '..', 'src')
    dist_path = File.absolute_path File.join(File.dirname(__FILE__), '..', '..', 'dist')
    zip_path = begin
      zip_file = File.open File.join(src_path, 'plugin.xml')
      plugin_doc = Nokogiri.XML(zip_file) { |config| config.strict.noblanks }
      plugin_element = plugin_doc.at_xpath(PLUGIN_SELECTOR, NS)
      version = plugin_element['version']
      File.join(dist_path, "avela-enrollment-v#{version}.zip")
    end

    ## Main
    ##
    FileUtils.mkdir_p(dist_path)
    FileUtils.rm_f(zip_path)
    FileUtils.cd(src_path) do
      puts "creating: #{zip_path}"
      Zip::File.open(zip_path, create: true) do |zipfile|
        Dir[File.join('**', '*.*')].each do |filename|
          puts "    adding: #{filename}"
          zipfile.add(filename, filename)
        end
      end
    end
  end
end
