require 'nokogiri'
require 'byebug'

class HTMLAnalyzer
  def initialize(origin_element_locator:)
    @origin_element_locator = origin_element_locator
  end

  def analyze(origin_file_path:, sample_file_path:)
    origin_page = parse_from_path(origin_file_path)
    sample_page = parse_from_path(sample_file_path)

    origin_element = origin_page.css(@origin_element_locator).first
    found_elements = find_potential_similar_elements(origin_element: origin_element, sample_page: sample_page)
    result = find_similar(origin_element: origin_element, elements_to_compare: found_elements)
    display_result(result)
  end

private

  def parse_from_path(path)
    File.open(path) { |f| Nokogiri::HTML(f) }
  end

  def find_potential_similar_elements(origin_element:, sample_page:)
    origin_element.attributes.map do |_, val|
      sample_page.search("[#{val.name}='#{val.value}']")
    end.flatten.uniq
  end

  def find_similar(origin_element:, elements_to_compare:)
    compared_elements = compare_elements(origin_element: origin_element, elements_to_compare: elements_to_compare)

    compared_elements.sort_by do |element|
      [
        element[:compared_attributes_result].count { |i| i[:matched] },
        element[:text_matched] ? 1 : 0
      ]
    end.last
  end

  def compare_elements(origin_element:, elements_to_compare:)
    elements_to_compare.map do |element|
      {
        text_matched: origin_element.text.strip == element.text.strip,
        element: element,
        compared_attributes_result: compare_attributes(origin_element.attributes, element.attributes),
      }
    end
  end

  def compare_attributes(origin_attrs, attrs)
    origin_attrs.map do |k, v|
      {
        attr_name: k,
        attr_value: v.value,
        matched: attrs[k]&.value == v.value
      }
    end
  end

  def display_result(res)
    puts res[:element].path
    puts res[:element].text.strip

    if res[:text_matched]
      puts "Element's text matched"
    end

    res[:compared_attributes_result].select { |i| i[:matched] }.each do |i|
      puts "Attr '#{i[:attr_name]}' with value '#{i[:attr_value]}' matched"
    end
  end
end

HTMLAnalyzer.new(
  origin_element_locator: '#make-everything-ok-button'
).analyze(origin_file_path: ARGV.first, sample_file_path: ARGV.last)
