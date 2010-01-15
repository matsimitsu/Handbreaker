xml.instruct!
xml.rss 'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd", :version => 2.0 do
  xml.channel do
    xml.title 'MP4 Podcast feed'
    xml.link '#'
    xml.language 'en-us'
    @folder.each do |f|
      xml.item do
        xml.title File.basename(f)
        xml.enclosure :url => "http://#{request.host}:#{request.port}/files/#{File.basename(f)}", :type => 'video/mp4'
        xml.pubdate File.new(f).ctime.strftime("%d-%m-%Y")
      end
    end
  end
end