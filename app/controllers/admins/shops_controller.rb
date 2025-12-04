require 'net/http'

class Admins::ShopsController < ApplicationController

  def create
    file = params[:file] #フォームからファイルを受け取る
    html_str = file.read           # ← これで内容を取得
    doc = Nokogiri::HTML(html_str)

    targets = doc.css('li > a.a-blue')

    targets.map do |a|
      road_number = a.at('img')&.[]('alt').split('号')[0].to_i  # <img>のalt
      prefecture = a.at('dl > dt')&.text&.strip # <dt>の文字列
      shop_name = a.at('dl > dd > h2')&.text&.strip # <h2>の文字列
      sticker_id = Sticker.find_by(road_number: road_number).id
      Shop.find_or_create_by(sticker_id: sticker_id, name: shop_name, prefecture: prefecture)
    end
    redirect_to admins_shops_path
  end

  def index
    @shops = Shop.all
  end

  def edit
  end

  def update_all
    shops = Shop.all
    multiple_hit_count = 0

    shops.each do |shop|
      query = "#{shop.prefecture} #{shop.name}"
      encoded = CGI.escape(query)

      url = "https://maps.googleapis.com/maps/api/geocode/json" \
            "?address=#{encoded}&key=#{ENV['GOOGLE_API_KEY']}"

      uri = URI(url)
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)

      status = json["status"]

      # APIエラーチェック
      if status != "OK"
        Rails.logger.warn "\e[33m[API ERROR] #{shop.name} → #{status}\e[0m"
        next
      end

      results = json["results"]

      if results.blank?
        Rails.logger.info "[NO HIT] #{query}"
        next
      end

      # 2件以上ヒットした場合のチェック
      if results.size > 1
        multiple_hit_count += 1
        Rails.logger.info "\e[31m[MULTI HIT] #{query} → #{results.size}件\e[0m"
      end

      # ---------- 保存データの抽出 ----------
      top = results.first

      formatted_address = top["formatted_address"] # address カラムへ保存

      # 郵便番号（"postal_code" の address_component を探す）
      zipcode = extract_zipcode(top)

      # 緯度経度（geometry下）
      location = top["geometry"]["location"]
      lat = location["lat"]
      lng = location["lng"]

      # ---------- 保存 ----------
      shop.update!(
        zipcode: zipcode,
        address: formatted_address,
        latitude: lat,
        longitude: lng
      )

      Rails.logger.info "\e[32m[Saved] #{shop.name} → ZIP: #{zipcode}, ADDRESS: #{formatted_address}, LAT: #{lat}, LNG: #{lng}\e[0m"
    end

    Rails.logger.info "======================================="
    Rails.logger.info "\e[31m2件以上ヒットした件数: #{multiple_hit_count}\e[0m"
    Rails.logger.info "======================================="

    redirect_to admins_shops_path, notice: "住所・緯度経度の更新が完了しました"
  end


  private

  # 郵便番号を抽出
  def extract_zipcode(result)
    comp = result["address_components"]
    zip = comp.find { |c| c["types"].include?("postal_code") }
    zip ? zip["long_name"] : nil
  end
end
