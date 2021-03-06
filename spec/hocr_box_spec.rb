#coding: utf-8

require_relative '../lib/hocr_box'

describe HOCRBox do
    
    before(:each) do
        @box ||=  HOCRBox.new(1,2,20,8)
    end
    
    describe '#coordinates' do
        it 'should have coordinates' do
            @box.coordinates.should == [1,2,20,8]
        end
        it 'should have #left' do
            @box.left.should == 1
        end
        it 'should have #right' do
            @box.right.should == 20
        end
        it 'should have #top' do
            @box.top.should == 2
        end
        it 'should have #bottom' do
            @box.bottom.should == 8
        end
        it 'should have height' do
            @box.height == 7
        end
        it 'should have width' do
            @box.width.should == 19
        end
    end
    
    describe "#to_s" do
        it "prints a human readable Box-Version with coordinates upper_left(x,y) bottom_right(x,y)" do
            @box.to_s.should == "(1,2)/(20,8)"
        end
        it "prints a human readable Box-Version with coordinates upper_left(x,y) bottom_right(x,y) with coordinates_to_s" do
              @box.coordinates_to_s.should == "(1,2)/(20,8)"
          end
    end
    
    describe "HTML-Methods" do
        it "has a to #to_image_html method" do
            @box.to_image_html(:css_class =>'test_class').should == "<span style='position:absolute; top:2px; left:1px; height:6px; width:19px;' class='test_class'></span>"
        end
        it "has an optional zoom which can be given as argument to #to_image_html" do
            @box.to_image_html(:zoom => 0.5).should == "<span style='position:absolute; top:1.0px; left:0.5px; height:3.0px; width:9.5px;' class='hocr_box'></span>"
        end
        
    end
    
    describe '#encloses?(element)' do
        it "tests waether given HOCRBox is enclosed by the current HOCRBox" do
            @box.encloses?( HOCRBox.new(0,3,19,7) ).should be_false
            @box.encloses?( HOCRBox.new(2,3,19,7) ).should be_true
        end
        it "encloses also itself" do
            @box.encloses?( @box ).should be_true
        end
    end
    
    describe '#to_css_style' do
        it 'should create css-style attributes' do
            @box.to_css_style.should == 'position:absolute; top:2px; left:1px; height:6px; width:19px;'
        end
        it 'by giving a zoom factor css positions should be altered' do
            @box.to_css_style(2).should == "position:absolute; top:4px; left:2px; height:12px; width:38px;"
        end
    end
    
    describe '#enclosed_by?(element)' do
        it 'should be enclosed by Boxes bigger than itself' do
            @box.enclosed_by?( HOCRBox.new(0,1,21,9) ).should be_true
        end
        it 'should not be enclosed by Boxes smaller than itself' do
            @box.enclosed_by?( HOCRBox.new(2,3,19,7) ).should be_false
        end
        it 'should be enclosed by Boxes of the same size' do
            @box.enclosed_by?( @box ).should be_true
        end
    end
    
    describe '#right_of?(element)' do
        it 'should be right of any box-element that has a smaller x1 value than current x2 value' do
            @box.right_of?( HOCRBox.new(0,2,0,8) ).should be_true #x1 == x2 -> Eine Linie
        end
        it 'should not be right of' do
            @box.right_of?( HOCRBox.new(1,2,2,8) ).should be_false
        end
    end
    
    describe '#left_of?(element)' do
        it 'should be left of any box-element that has a larger x1 than the current box has x2' do
            @box.left_of?( HOCRBox.new(21,2,21,8) ).should be_true #x1 == x2 -> Eine Linie
        end
        it 'should not be left of' do
            @box.left_of?( HOCRBox.new(1,2,2,8) ).should be_false
        end
    end
    
    describe '#left_distance_to(element)' do
        it 'element should be 5px left box' do
           HOCRBox.new(25,0,30,0).left_distance_to(@box).should ==  5
        end
    end
    
    describe '#right_distance_to(element)' do
        it 'box should be 2px right of element' do
             @box.right_distance_to(HOCRBox.new(22,0,24,0)).should == 2
        end
    end
    
    describe '#top_distance_to(element)' do
        it 'box should be 9px below of element' do
             HOCRBox.new(109,241,206,274).top_distance_to(HOCRBox.new(160,196,1117,232)).should == 9
        end
    end
    
    describe '#bottom_distance_to(element)' do
        it 'box should be 2px above of element' do
            HOCRBox.new(160,196,1117,232).bottom_distance_to(HOCRBox.new(109,241,206,274)).should == 9
        end
    end
    
    
end