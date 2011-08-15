#coding: utf-8
require_relative "ocr_element"
require 'nokogiri'
require 'pp'

class OCRPage < OCRElement
    
    attr_accessor :meta_data, :page_number, :dimensions

    def initialize(filename)
        doc = process_hocr_html_file filename
        page_inhalt = doc.at_css("div.ocr_page")
        coordinates, @page_number = extract_bbox_ppageno page_inhalt['title']
        children = []
        super('ocr_page', children, coordinates)
    end
    
    
    def each_block
       
    end
    
    def each_paragraph
       
    end
    
    def each_line
        
    end
    
    def each_word
        
    end
    
    def extract_bbox_ppageno( ocr_html_text_fragment )
        bbox, ppageno = ocr_html_text_fragment.split(';')
        ppageno =~ /(\d+)/
        [ extract_coordinates_from_string(bbox) , $1.to_i ]
    end
    
    def process_hocr_html_file(filename)
        hocr_doc = Nokogiri::HTML(File.open(filename,"r"))
    end
    
    def enclosed_words(box)
    end
    
end
