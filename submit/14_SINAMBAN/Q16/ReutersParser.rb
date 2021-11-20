require "nokogiri"

class ReutersParser
  def parse(page)
    data = Nokogiri::HTML(page.body)
    title = self.extract_title(data)
    date = self.extract_date(data)
    text = self.extract_text(data)
    {:title => title, :date => date, :text => text}
  end

  private

  def extract_title(data)
    data.xpath("//h1[starts-with(@class,'Headline')]").text
  end

  def extract_text(data)
    text =''
    data.xpath("//p[starts-with(@class, 'Paragraph')]").each { |d| 
      text += d
    }
    text
  end

  def extract_date(data)
    date_meta_data = data.search("meta[name='REVISION_DATE']")
    date = ''
    date_meta_data.each{|md|
      date = md['content'] if !md['content'].nil?
    }
    date
  end
end