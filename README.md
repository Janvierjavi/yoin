# Yoin

## 概要
ランダムで出力される３文字を頭出しとして、5・７・５を考える（あいうえお作文の川柳バージョン）  
生み出された5・７・５の風情を、その余韻(Yoin)をユーザー同士で共有し、愉しむ  

## コンセプト
投稿するお題が決まってるツイッターのようなイメージ  

## バージョン
* Ruby 2.6.3
* Rails 5.2.3

## 機能一覧
* ログイン機能
* ユーザー登録
  - 名前、メールアドレス、パスワードは必須
* 退会機能
* プロフィール編集機能
  - プロフィール画像をアイコンとして設定ができる
* ５・７・５投稿一覧機能
  - フォロー中ユーザー + 自分の投稿一覧(Home)
  - 全ユーザーの投稿一覧(Discover)
  - お気に入り投稿一覧(Collection)
* ５・７・５投稿機能
  - ランダムで出力された3文字が各ラインの頭出しの文字（変更不可）
  - 投稿画面に遷移毎、ランダムで出力される3文字が変わる
  - ひらがなの入力のみ許可
* 投稿削除機能
  - 投稿者のみ実行可能
* お気に入り機能
* フォロー機能

## カタログ設計
https://docs.google.com/spreadsheets/d/1Q9W6ItcnblGbpJCEGqY3b9TDbV4O9-h0gyI_apMzfA4/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1PRG_PsnG67MpTMfUI3AoTI7EaIN7mQgGflb_DR-FpF4/edit?usp=sharing

## ER図
https://docs.google.com/spreadsheets/d/1ALLUavRvFHwCXCj8W5GsN7SIYTjc4RobO1iaLy63qd8/edit?usp=sharing

## 画面遷移図
https://docs.google.com/spreadsheets/d/1b-sd0Jshizpb0BNUR1KyG3UuqY7j2RWVYm4NBZVPFyI/edit?usp=sharing

## 画面ワイヤーフレーム(スマホ想定)
https://docs.google.com/spreadsheets/d/1wECtxjS6ogei-ycEGbEx9nwZu5QbMhXDKD6Oj1We5fQ/edit?usp=sharing

## 使用予定Gem
* capistrano
* unicorn
* carrierwave
* mini_magick
* fog-aws
* search_cop