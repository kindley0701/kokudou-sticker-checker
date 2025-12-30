class Shop < ApplicationRecord
  belongs_to :sticker

  enum prefecture: {
    北海道: 1,
    青森県: 2,
    岩手県: 3,
    宮城県: 4,
    秋田県: 5,
    山形県: 6,
    福島県: 7,
    茨城県: 8,
    栃木県: 9,
    群馬県: 10,
    埼玉県: 11,
    千葉県: 12,
    東京都: 13,
    神奈川県: 14,
    新潟県: 15,
    富山県: 16,
    石川県: 17,
    福井県: 18,
    山梨県: 19,
    長野県: 20,
    岐阜県: 21,
    静岡県: 22,
    愛知県: 23,
    三重県: 24,
    滋賀県: 25,
    京都府: 26,
    大阪府: 27,
    兵庫県: 28,
    奈良県: 29,
    和歌山県: 30,
    鳥取県: 31,
    島根県: 32,
    岡山県: 33,
    広島県: 34,
    山口県: 35,
    徳島県: 36,
    香川県: 37,
    愛媛県: 38,
    高知県: 39,
    福岡県: 40,
    佐賀県: 41,
    長崎県: 42,
    熊本県: 43,
    大分県: 44,
    宮崎県: 45,
    鹿児島県: 46,
    沖縄県: 47
  }

  # (1) 生成を行うクラスメソッド
  def self.generate_marker_jobs_json
    require 'json'
    require 'fileutils'

    # JSON 出力先
    json_path = Rails.root.join("tmp", "marker_jobs.json")
    FileUtils.mkdir_p(File.dirname(json_path))

    jobs = []

    # 同一店舗（name, lat, lng）で sticker_id が 2つ以上のグループ
    groups = Shop.group(:name, :latitude, :longitude)
                .having("COUNT(DISTINCT sticker_id) >= 2")
                .pluck(:name, :latitude, :longitude)

    groups.each do |name, lat, lng|
      shops = Shop.where(name: name, latitude: lat, longitude: lng)

      # road_number を取得して昇順に並べる
      road_numbers = shops.map { |s| s.sticker.road_number }.sort

      next if road_numbers.size < 2   # 念のため

      small = "%03d" % road_numbers[0]
      large = "%03d" % road_numbers[1]

      # 出力ファイル名
      output_filename = "#{small}_#{large}.png"
      output_path = "public/images/combined/#{output_filename}"

      # 使用する画像
      image_paths = road_numbers.map { |num| "public/images/#{'%03d' % num}.png" }

      # JSON の 1 レコード
      jobs << {
        name: name,
        lat: lat,
        lng: lng,
        output: output_path,
        images: image_paths
      }
    end

    # JSON 書き込み
    File.open(json_path, "w") do |f|
      f.write(JSON.pretty_generate(jobs))
    end

    puts "Generated JSON: #{json_path}"
  end


  # (2) 個別 Shop のアイコンURLを返すインスタンスメソッド
  #     同位置に複数レコードがある場合は合成ファイルを返す
  def combined_marker_url
    group_shops = Shop.where(name: name, latitude: latitude, longitude: longitude)
    if group_shops.count < 2
      # 単一ステッカー：通常の画像（public/images または app/assets から）
      "/images/#{format('%03d', sticker.road_number)}.png"
    else
      filename = Digest::MD5.hexdigest("#{name}-#{latitude}-#{longitude}") + ".png"
      "/images/combined/#{filename}"
    end
  end
end
