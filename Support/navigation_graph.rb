require 'graphr'
require_relative '../PageObject/page'

class NavigationGraph
  def initialize(starting_page)
    @starting_page = starting_page
    @dg = DirectedGraph.new
  end#intialize

  def build
    start = get_page @starting_page
    if start.nil?
      start = Page.build_page @starting_page
      visited_page start
      traverse start
    end
    @dg
  end#build

  def traverse(node)
    if node.class <= Page
      node.elements.each do |_key, element|
        @dg.add_link node, element
        traverse element
      end#do
    else
      node.children.each do |child|
        @dg.add_link node, child
        traverse child
      end#do
      unless node.next_page.nil?
        next_page = get_page node.next_page
        if next_page.nil?
          next_page = Page.build_page node.next_page
          @dg.add_link node, next_page
          visited_page next_page
          traverse next_page
        end
      end
    end#else
  end#traverse

  def image
    dgp = DotGraphPrinter.new @dg.links
    File.open('dotfile', "w") {|f| f.write dgp.to_dot_specification}
    system('C:\Program Files (x86)\Graphviz2.38\bin\dot.exe', '-Tpng', '-ograph.png', '-Gdpi=300', 'dotfile')
  end

  def get_page(page_class)
    @pages ||= {}
    @pages[page_class] if @pages.has_key? page_class
  end

  def visited_page(page)
    @pages ||= {}
    @pages[page.class] = page unless @pages.has_key? page.class
  end
end#NavigationGrapher

class DotGraphPrinter
  @@default_node_shaper = proc{|n|
    if n.class <= Page
      'box'
    elsif n.class <= PageObject::ElementObject
      'diamond'
    else
      'circle'
    end
  }

  @@default_node_labeler = proc{|n|
    if Symbol===n
      n.id2name
    elsif String===n
      n
    elsif n.class <= PageObject::ElementObject
      n.name
    elsif n.class <= Page
      n.class.to_s
    else
      n.inspect
    end
  }
end