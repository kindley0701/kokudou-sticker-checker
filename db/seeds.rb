# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
   admin.password = ENV['ADMIN_PASSWORD']
end

Sticker.find_or_create_by!( road_number: '1', body: '' )
Sticker.find_or_create_by!( road_number: '2', body: '' )

Shop.find_or_create_by!( sticker_id: '1', name: '道の駅 箱根峠', prefecture: 14, zipcode: '250-0521', address: '神奈川県足柄下郡箱根町箱根381‑22', latitude: 35.1866 , longitude: 139.0156 )
Shop.find_or_create_by!( sticker_id: '1', name: 'KADODEOOIGAWA', prefecture: 22, zipcode: '428-0008', address: '静岡県島田市竹下62', latitude: 34.849516 , longitude: 138.118582 )
Shop.find_or_create_by!( sticker_id: '1', name: '日本橋観光案内所', prefecture: 13, zipcode: '103‑0027', address: '東京都中央区日本橋1‑1‑1', latitude: 35.683725 , longitude: 139.774049 )
Shop.find_or_create_by!( sticker_id: '1', name: 'レンタルボックスCABIN', prefecture: 27, zipcode: '530‑0001', address: '大阪府大阪市北区梅田1‑2‑2 大阪駅前第2ビルB2F', latitude: 35.6940 , longitude: 135.4980 )
Shop.find_or_create_by!( sticker_id: '1', name: '名阪関ドライブイン', prefecture: 24, zipcode: '519‑1114', address: '三重県亀山市関町萩原39番地', latitude: 34.840501 , longitude: 136.402655 )
Shop.find_or_create_by!( sticker_id: '1', name: '三交イン京都八条口＜雅＞', prefecture: 26, zipcode: '601‑8002', address: '京都府京都市南区東九条上殿田町48番地1', latitude: 34.983742 , longitude: 135.758857 )
Shop.find_or_create_by!( sticker_id: '1', name: 'ラジコン天国 名古屋店', prefecture: 23, zipcode: '455‑0021', address: '愛知県名古屋市港区木場町9‑1', latitude: 35.099742 , longitude: 136.896253 )
Shop.find_or_create_by!( sticker_id: '2', name: '道の駅 みはら神明の里', prefecture: 34, zipcode: '729‑0324', address: '広島県三原市糸崎4丁目21‑1', latitude: 34.396816 , longitude: 133.103874 )
Shop.find_or_create_by!( sticker_id: '2', name: 'レンタルボックスCABIN', prefecture: 22, zipcode: '530‑0001', address: '大阪府大阪市北区梅田1‑2‑2 大阪駅前第2ビルB2F', latitude: 35.6940 , longitude: 135.4980 )
Shop.find_or_create_by!( sticker_id: '2', name: '長沢ガーデン', prefecture: 34, zipcode: '747‑1221', address: '山口県山口市鋳銭司2296', latitude: 34.070782 , longitude: 131.465488 )
Shop.find_or_create_by!( sticker_id: '2', name: 'セブン-イレブン 阪神甲子園球場前店', prefecture: 28, zipcode: '663‑8151', address: '兵庫県西宮市甲子園洲鳥町4‑12', latitude: 34.722531 , longitude: 135.360874 )
Shop.find_or_create_by!( sticker_id: '2', name: 'セブン-イレブン 門司港松本店', prefecture: 40, zipcode: '801‑0863', address: '福岡県北九州市門司区栄町11‑162', latitude: 33.947008 , longitude: 130.967922 )
Shop.find_or_create_by!( sticker_id: '2', name: 'セブン-イレブン 早島バイパス店', prefecture: 33, zipcode: '701‑0304', address: '岡山県都窪郡早島町早島3458‑1', latitude: 34.61086 , longitude: 133.827715 )
