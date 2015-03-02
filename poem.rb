#!/usr/bin/ruby
#====================================================
#
# Usage: ruby poem.rb [<bnf file>] [<sub-type>]
#    Eg. ruby poem.rb shakespeare.bnf rough

class BNF_Dictionary
  
  def initialize(bnf_file)
    @grammar = {}
    File.open(bnf_file,"r") do |f|
      f.each do |line|
        line_split = line.split('=')
        @grammar[line_split[0]] = []
        line_split[1].split('|').each do |syntax|
          @grammar[line_split[0]].push(syntax)
        end
      end
    end
  end
        
  def generate(key,num)
		key
    gram = @grammar[key]
    i = rand(gram.length - 1)
    string = ""
    if !gram[i].include?"<" 
      string = gram[i]
    else
      gram[i].split().each do |word|
        if !word.include?"<"
          string = string.concat(word).concat(" ")
        else
          string = string.concat(generate(word,1).concat(" "))
        end
      end
    end
    return string.gsub('newline','')
  end    

  def generate_pretty(key)
    poem = generate(key,1)
    capitalize = true
    is_title = true
    is_paragraph = false
    new_poem = ""
    lines = poem.split('\n')
    lines.push("\n")
    lines.each do |line|
      line = line.rstrip.lstrip
      line = line.gsub(' ,',',')
      line = line.gsub(' ?','?')
      line = line.gsub(' !','!')
      line = line.gsub(' .','.')
      line = line.gsub(' :',':')
      line = line.gsub(' \'','\'')
      if capitalize
        line = line.capitalize
        capitalize = false
      end
      if is_title
        mydate = Time.now
        new_poem = new_poem.concat("<h1>").concat(line).concat("</h1>\n<h2>by The Poet's Computer, ").concat(mydate.strftime("%d %B %Y")).concat("</h2>\n")
        is_title = false
      else
        if line.length < 1
          if is_paragraph
            new_poem = new_poem.concat("</p>")
          end
          is_paragraph = false
        else
          if !is_paragraph
            new_poem = new_poem.concat("\n\n<p>")
            line = line.capitalize
          end
          is_paragraph = true
          new_poem = new_poem.concat(line).concat("<break>")
        end
        if line.include?"." or line.include?"!" or line.include?"?" or line.include?"!"
          capitalize = true
        end
      end
    end
    new_poem = new_poem.gsub('<break><break>','<break>')
    new_poem = new_poem.gsub('<break></p>','</p>')
    new_poem = new_poem.gsub('<break>','<br />\n')
    lines = new_poem.split("\n")
    new_poem = ""
    is_paragraph = false
    capitalize = false
    lines.each do |line|
      if capitalize
        line = line.capitalize()
        capitalize = false
      end
      if line.include?"</p>"
        is_paragraph = false
        last_char = line.rsplit('</p>',1)[0][-1]
        if last_char.include?"." or last_char.include?"-" or last_char.include?"," or last_char.include?"!" or last_char.include?"?" or last_char.include?"!"
          new_poem = new_poem.concat(line).concat("\n")
        else
          new_poem = new_poem.concat(line.gsub('</p>','.</p>\n'))
        end
      elsif line.include?"<p>"
        is_paragraph = true
        new_poem = new_poem.concat(line).concat("\n")
      else
        if is_paragraph
          last_char = line.reverse.split('<br />',2)[0][-1].collect(&:reverse).reverse
          if last_char.include? "." or last_char.include? "-" or last_char.include? "," or last_char.include? "!" or last_char.include? "?" or last_char.include? "!"
            #do nothing
          else
            if rand(20) <2
              new_poem = new_poem.concat(line.gsub('<br />','?<br />\n'))
              capitalize = true
            elsif (0 + rand(20))<2
              new_poem = new_poem.concat(line.gsub('<br />','.<br />\n'))
              capitalize = true
            elsif (0 + rand(20))<2
              new_poem = new_poem.concat(line.gsub('<br />','!<br />\n'))
              capitalize = true
            elsif (0 + rand(20))<2
              new_poem = new_poem.concat(line.gsub('<br />',',<br />\n'))
            else
              new_poem = new_poem.concat(line).concat("\n")
            end
          end
        else
          new_poem = new_poem.concat(line).concat("\n")
        end
      end
    end

    new_poem = new_poem.gsub('..','.')
    new_poem = new_poem.gsub('?.','!')
    new_poem = new_poem.gsub('!.','?')
    new_poem = new_poem.gsub(' i ',' I ')
    return new_poem
  end
end
  
bnf_file = ARGV[0].nil? ? "poems.bnf" : ARGV[0]
sub_type = ARGV[1].nil? ? "<poem>" : "<#{ARGV[1]}>"

bnf = BNF_Dictionary.new(bnf_file)
puts(bnf.generate_pretty("#{sub_type}"))
