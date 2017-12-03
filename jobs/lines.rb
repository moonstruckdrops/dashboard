require 'mechanize'

SCHEDULER.every '1m', :first_in => 0 do |job|
  agent = Mechanize.new
  page = agent.get("https://transit.yahoo.co.jp/traininfo/area/4/")
  items = []
  # 変数名は路線ナンバーで表現
  # 山手線
  jy_status = page.search("#mdAreaMajorLine div:nth-child(4) table tr:nth-child(2) td:nth-child(2)").text
  jy_detail = page.search("#mdAreaMajorLine div:nth-child(4) table tr:nth-child(2) td:nth-child(3)").text
  items << { name: "山手線", status: jy_status, detail: jy_detail }

  send_event('lines', { items: items }) unless items.empty?
end
