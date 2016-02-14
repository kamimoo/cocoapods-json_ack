require 'jsonpath'
require 'CFPropertyList'

module Pod
  class Command
    class JSONAck < Command
      module PlistKey
        TITLE = :Title
        FOOTER_TEXT = :FooterText
        TYPE = :Type
      end
      PlistKey.freeze

      self.summary = 'Merge license info in JSON to Acknowledgements.plist'

      self.description = <<-DESC
        Merge license info in JSON to Acknowledgements.plist
      DESC

      def self.options
        [
          ['--in=FILE_PATH', 'Acknowledgements file'],
          ['--json=FILE_PATH', 'JSON file which contains license info']
        ]
      end

      def self.merge(args)
        self.new(args).run
      end

      def initialize(argv)
        if argv.is_a?(CLAide::ARGV)
          UI.puts argv.arguments
          @acknowledgements_path = argv.option('in')
          @json_path = argv.option('json')
          @json_pattern = {
            PlistKey::TITLE => '$..name',
            PlistKey::FOOTER_TEXT => '$..licenseSources.license.sources[0].text'
          }
          super
        else
          @acknowledgements_path = argv[:in]
          @json_path = argv[:json]
          @json_pattern = argv[:pattern]
        end
      end

      def validate!
        super
        help! 'Input files are required.' unless @acknowledgements_path && @json_path
      end

      def run
        main_plist = CFPropertyList::List.new(file: @acknowledgements_path)
        json = File.read(@json_path)
        titles, texts = @json_pattern.map { |_, v| JsonPath.on(json, v) }
        titles.zip(texts).each do |title, text|
          data = CFPropertyList.guess(
            PlistKey::FOOTER_TEXT => text,
            PlistKey::TITLE => title,
            PlistKey::TYPE => 'PSGroupSpecifier'
          )
          main_plist.value.value['PreferenceSpecifiers'].value.push(data)
        end
        main_plist.formatted = true
        UI.puts main_plist.to_str(CFPropertyList::List::FORMAT_XML)
      end
    end
  end
end
