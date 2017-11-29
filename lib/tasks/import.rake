namespace(:db) do
  namespace :seed do
    desc 'seed the database from NVD xml'
    task :parser => :environment do
      class Cvetodatabase < Nokogiri::XML::SAX::Document
        def initialize
          @vals = {}

          @valid_elements = Array[
              'nvd', 'vuln:cve-id', 'vuln:published-datetime', 'vuln:last-modified-datetime',
              'cvss:score', 'cvss:access-vector', 'cvss:access-complexity', 'cvss:authentication',
              'cvss:confidentiality-impact', 'cvss:integrity-impact', 'cvss:availability-impact',
              'cvss:source', 'cvss:generated-on-datetime', 'cvss:base_metrics', 'vuln:cvss',
              'vuln:summary', 'vuln:reference', ' vuln:source', 'vuln:references', 'vuln:source',
              'entry', 'vuln:vulnerable-software-list', 'vuln:product', 'vuln:cwe',
              'vuln:security-protection', 'vuln:assessment_check', 'vuln:definition',
              'vuln:scanner'
          ]

          @ignored_elements = Array[
              'cpe-lang:logical-test', 'vuln:vulnerable-configuration', 'cpe-lang:fact-ref'
          ]

          @valid_elements += @ignored_elements
          end

        # Callback for when the start of a XML element is reached
        #
        # @param element XML element
        # @param attributes Attributes for the XML element
        def start_element(element, attributes = [])
          @tag = element
          @vals[@tag] = ''

          unless @valid_elements.include?(element)
            puts "New XML element detected: #{element}. Please report this"
          end

          case element
          when 'entry'
            @entry = Entry.create
            @entry.save

          when 'vuln:cvss'
            @cvss = @entry.cvsses.create
            @cvss.save

          when 'vuln:cwe'
            @entry.attributes = { cwe: Hash[attributes]['id'] }
            @entry.save

          when 'vuln:references'
            @reference = @entry.references.create
            @reference.attributes = {
              ref_type: Hash[attributes]['reference_type']
            }
            @reference.save

          when 'vuln:reference'
            @reference.attributes = {
              href: Hash[attributes]['href'],
              language: Hash[attributes]['xml:lang']
            }
            @reference.save

          when 'vuln:assessment_check '
            @ass = @entry.assessment_check.create
            @ass.attributes = {
              name: Hash[attributes]['name'],
              href: Hash[attributes]['href'],
              system: Hash[attributes]['system']
            }
            @entry.save

          when 'vuln:definition'
            @scanner = @entry.scanners.create
            @scanner.attributes = {
              name: Hash[attributes]['name'],
              href: Hash[attributes]['href'],
              system: Hash[attributes]['system']
            }
            @scanner.save
          end
        end

        # Called when the inner text of a element is reached
        #
        # @param text
        def characters(text)
          if @vals[@tag].nil?
            @vals[@tag] = text.strip
          else
            @vals[@tag] << text.strip
          end
        end

        # Called when the end of the XML element is reached
        #
        # @param element
        def end_element(element)
          # puts "End element: #{element}"
          @tag = nil
          case element
          when 'vuln:cve-id'
            @entry.attributes = { cve: @vals['vuln:cve-id'] }
            @entry.save

          when 'vuln:published-datetime'
            @entry.attributes = { published_datetime: @vals['vuln:published-datetime']	}
            @entry.save

          when 'vuln:last-modified-datetime'
            @entry.attributes = { last_modified_datetime: @vals['vuln:last-modified-datetime']	}
            @entry.save

          when 'vuln:summary'
            @entry.attributes = { summary: @vals['vuln:summary'] }
            @entry.save

          when 'vuln:security-protection'
            @entry.attributes = { security_protection: @vals['vuln:security-protection'] }
            @entry.save

          when 'vuln:product'
            @product = @entry.vulnerable_software_lists.create
            @product.attributes = { product: @vals['vuln:product'] }
            @product.save

          when 'vuln:cvss'
            @cvss.attributes = {
              score: @vals['cvss:score'],
              access_vector: @vals['cvss:access-vector'],
              access_complexity: @vals['cvss:access-complexity'],
              authentication: @vals['cvss:authentication'],
              confidentiality_impact: @vals['cvss:confidentiality-impact'],
              integrity_impact: @vals['cvss:integrity-impact'],
              availability_impact: @vals['cvss:availability-impact'],
              source: @vals['cvss:source'],
              generated_on_datetime: @vals['cvss:generated-on-datetime']
            }
            @cvss.save

          when 'vuln:references'
            @reference.attributes = {
              source: @vals['vuln:source'],
              reference: @vals['vuln:reference']
            }
            @reference.save
          end
        end

        def end_document; end
      end

      parser = Nokogiri::XML::SAX::Parser.new(Cvetodatabase.new)

      # Feed the parser some XML
      parser.parse(File.open(Rails.root + 'lib/assets/data/nvdcve-2.0-modified.xml'))
    end
  end
end
